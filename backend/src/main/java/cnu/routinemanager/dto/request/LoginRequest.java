package cnu.routinemanager.dto.request;

import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class LoginRequest {
    @NotNull
    private String email;

    public LoginRequest(String email) {
        this.email = email;
    }
}
