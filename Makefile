define validate =
	set -e
	for v in $(find ./test-values -name "*.yaml") ; do
		helm template -f ${v} . | kubeconform
		echo "✓ Validating chart with ${v}"
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

.SILENT: validate package snapshot test

.ONESHELL:

validate: ; $(value validate)

package: validate
	mkdir -p target
	helm package --dependency-update --destination target/ .

snapshot: validate ; $(value snapshot)

test: ; $(value test)
