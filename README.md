# This is just a demo Hello Worl app

# Serve as backend REST API

# Special part is the CORS injection of REACT

- externalIP once deploy to GKE - LB or local run

- .allowedOrigins("http://34.9.46.190:80", "http://localhost:3000")

`

@SpringBootApplication
public class MyDemoJavaDevopsApplication {

    public static void main(String[] args) {
    	SpringApplication.run(MyDemoJavaDevopsApplication.class, args);

    }

    @Value("${frontend.url:http://localhost:3000}")
    private String FRONTEND_URL;

    @Bean
    public WebMvcConfigurer corsConfigurer() {
    	return new WebMvcConfigurer() {
    		@Override
    		public void addCorsMappings(CorsRegistry registry) {
    			registry.addMapping("/**")
    					.allowedOrigins("http://34.9.46.190:80", "http://localhost:3000")
    					.allowedMethods("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS")
    					.allowedHeaders("*")
    					.allowCredentials(true);
    		}
    	};
    }

}
`
