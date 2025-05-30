package dev.padak.backend.QualityTest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@EnableWebSecurity
@EnableMethodSecurity
@SpringBootApplication
@Import(org.padak.JwtSecurityAutoConfiguration.class)
public class QualityTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(QualityTestApplication.class, args);
	}

}
