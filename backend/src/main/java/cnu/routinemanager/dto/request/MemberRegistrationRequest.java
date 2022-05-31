package cnu.routinemanager.dto.request;


import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberRegistrationRequest {
    @NotNull
    private String email;

    public MemberRegistrationRequest(String email) {
        this.email = email;
    }
}
