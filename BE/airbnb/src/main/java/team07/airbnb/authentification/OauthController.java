package team07.airbnb.authentification;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
public class OauthController {

    private final OauthService oauthService;

    @GetMapping("/login/oauth")
    public String oauthGithub(@RequestParam String code) {

        String accessToken = oauthService.generateAccessToken(code);
        System.out.println("accessToken = " + accessToken);
        Map<String, String> userAttributes = oauthService.getUserAttributes(accessToken);
        System.out.println("userAttributes = " + userAttributes);
        LoginResponse loginResponse = new LoginResponse(userAttributes.get("login"), userAttributes.get("avatar_url"), userAttributes.get("email"), "JWT");
        System.out.println("loginResponse = " + loginResponse);
        //return ResponseEntity.ok().body(loginResponse);
        return "123";
    }


}
