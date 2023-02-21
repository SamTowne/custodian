localdev:
	cp .localdev/event.json event.json
	echo "local dev configured, use act to run gitlab actions locally: act -e event.json"