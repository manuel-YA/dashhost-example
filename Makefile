

run_web:
	flutter run -d chrome --web-browser-flag "--disable-web-security"


deploy_test:
	git add . && git commit -m"deploy test" && git push