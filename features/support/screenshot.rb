require 'selenium-webdriver'

%x[rm -r aipim/screenshots/*]

Before do |scenario|
	@ScenarioTitle = scenario.title
	@ScenarioDescription = scenario.description
	@FeatureFile = scenario.file.to_s.split('/')
	@FeatureFile.delete_at(0)
	@FeatureFile = @FeatureFile.join('/')
	@FeatureName = scenario.feature.title
	@ScenarioTags = scenario.source_tag_names

	page.driver.browser.manage.window.maximize
	page.driver.browser.manage.window.resize_to(1366, 768)
end

After do
	config = YAML.load_file("config/aipim.yml")
	
	if (@ScenarioTags.include?('@screenshot') && @ScenarioTags.include?('@javascript') && !page.driver.browser.nil? && config['screenshot'])
		path = "aipim/screenshots/#{@FeatureFile}"
		system("mkdir -p #{path}")

		sleep(1.0)
		page.driver.save_screenshot("#{path}/#{Time.now.to_i}.png")
	end
end
