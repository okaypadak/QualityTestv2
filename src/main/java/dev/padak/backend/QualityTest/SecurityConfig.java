package dev.padak.backend.QualityTest;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@Configuration
@EnableWebSecurity
@Import({org.padak.JwtSecurityAutoConfiguration.class, org.padak.JwtService.class})
public class SecurityConfig {
}
