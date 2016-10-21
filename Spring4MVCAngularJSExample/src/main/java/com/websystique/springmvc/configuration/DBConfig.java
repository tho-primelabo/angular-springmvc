package com.websystique.springmvc.configuration;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.websystique.springmvc.utility.DBUtility;

@Configuration 

public class DBConfig {
	@Bean
	public static DataSource getDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		Properties prop = new Properties();
		InputStream inputStream = DBUtility.class.getClassLoader().getResourceAsStream("/config.properties");
        try {
			prop.load(inputStream);
		
	        String driver = prop.getProperty("driver");
	        String url = prop.getProperty("url");
	        String user = prop.getProperty("user");
	        String password = prop.getProperty("password");
	        System.out.println("driver:"+ driver +" url:" + url);
		    dataSource.setDriverClassName(driver);
		    dataSource.setUrl(url);
		    dataSource.setUsername(user);
		    dataSource.setPassword(password);
        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return dataSource;
	}
	
}
