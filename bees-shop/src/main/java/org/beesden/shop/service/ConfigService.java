package org.beesden.shop.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beesden.shop.model.Config;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.fasterxml.jackson.databind.ObjectMapper;

@SuppressWarnings("unchecked")
@Repository
@Transactional
public class ConfigService extends Service<Config> {

	public ConfigService() {
		super(Config.class.getName());
	}

	public ModelMap getConfig(ModelMap model) {
		Map<String, Object> config = new HashMap<String, Object>();
		List<Config> configList = findAll(" ");

		for (Config configItem : configList) {
			if (configItem.getType() != null && configItem.getType().equals("map")) {
				try {
					HashMap<String, Object> result = new ObjectMapper().readValue(configItem.getValue(), HashMap.class);
					config.put(configItem.getName(), result);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				config.put(configItem.getName(), configItem.getValue());
			}
		}
		model.addAttribute("config", config);
		return model;
	}
}
