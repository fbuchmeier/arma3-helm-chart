define validate-helm =
	set -e
	for v in $(find ./test-values -name "*.yaml") ; do
		helm template -f ${v} . | kubeconform
		echo "✓ Validating chart with ${v}"
	done
endef

define validate-shell =
	set -e
	for s in $(find ./scripts -name "*.bash") ; do
		shellcheck -S info ${s}
		echo "✓ Validating script ${s}"
	done
endef

define validate-yaml =
	set -e
	for y in $(find ./ -maxdepth 1 -name "*.yaml") ; do
		yamllint ${y}
		echo "✓ Validating YAML ${y}"
	done
endef

define snapshot =
	set -e
	mkdir -p test-fixtures
	for v in $(find ./test-values -name "*.yaml") ; do
		helm template -f ${v} . > ./test-fixtures/$(basename ${v})
		echo "✓ Updating snapshot for ${v}"
	done
endef

define test =
	set -e
	for v in $(find ./test-values -name "*.yaml") ; do
		helm template -f ${v} . | diff - ./test-fixtures/$(basename ${v})
		echo "✓ Diffing ${v} with ./test-fixtures/$(basename ${v})"
	done
endef

.SILENT: validate validate-helm validate-yaml validate-shell package snapshot test release

.ONESHELL:

validate-helm: ; $(value validate-helm)

validate-yaml: ; $(value validate-yaml)

validate-shell: ; $(value validate-shell)

validate: validate-yaml validate-helm validate-shell

package: validate
	mkdir -p target
	helm package --dependency-update --destination target/ .

snapshot: validate ; $(value snapshot)

test: ; $(value test)

release:
	helm-docs .
	git add README.md
	git commit -m "docs: Updated Readme to latest verion"
