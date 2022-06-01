package cnu.routinemanager.dto.response;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberRegistrationResponse {
    private Long id;

    private String email;

    public MemberRegistrationResponse(Long id, String email) {
        this.id = id;
        this.email = email;
    }
}
