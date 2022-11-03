define validate-helm =
	set -e
	shopt -s globstar
	for v in ./test-values/**/*.yaml ; do
		helm template -f ${v} . | kubeconform
		echo "✓ Validating chart with ${v}"
	done
endef

define validate-shell =
	set -e
	shopt -s globstar
	for s in ./scripts/**/*.bash ; do
		shellcheck -S info "${s}"
		echo "✓ Validating script ${s}"
	done
endef

define validate-yaml =
	set -e
	for y in ./*.yaml ; do
		yamllint "${y}"
		echo "✓ Validating YAML ${y}"
	done
endef

define validate-markdown =
	set -e
	shopt -s globstar
	for m in ./docs/**/*.md ; do
		mdl "${m}"
		echo "✓ Validating Markdown ${m}"
	done
endef

define snapshot =
	set -e
	shopt -s globstar
	mkdir -p test-fixtures
	for v in ./test-values/**/*.yaml ; do
		helm template -f "${v}" . > ./test-fixtures/$(basename "${v}")
		echo "✓ Updating snapshot for ${v}"
	done
endef

define test =
	set -e
	shopt -s globstar
	for v in ./test-values/**/*.yaml ; do
		helm template -f "${v}" . | diff - ./test-fixtures/$(basename "${v}")
		echo "✓ Diffing ${v} with ./test-fixtures/$(basename ${v})"
	done
endef

.SILENT: validate validate-helm validate-yaml validate-shell validate-markdown package snapshot test release

.ONESHELL:
SHELL := /bin/bash

validate-helm: ; $(value validate-helm)

validate-yaml: ; $(value validate-yaml)

validate-shell: ; $(value validate-shell)

validate-markdown: ; $(value validate-markdown)

validate: validate-yaml validate-helm validate-shell validate-markdown

package: validate
	mkdir -p target
	helm package --dependency-update --destination target/ .

snapshot: validate ; $(value snapshot)

test: ; $(value test)

release:
	helm-docs .
	git add README.md
	git commit -m "docs: Updated Readme to latest verion"
