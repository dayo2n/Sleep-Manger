package cnu.routinemanager.controller;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cnu.routinemanager.dto.request.MemberRegistrationRequest;
import cnu.routinemanager.dto.response.MemberRegistrationResponse;
import cnu.routinemanager.service.MemberService;

@RestController
@RequestMapping("/members")
public class MemberController {
    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping
    public ResponseEntity<MemberRegistrationResponse> registerMember(@Valid @RequestBody MemberRegistrationRequest memberRegistrationRequest) {
        MemberRegistrationResponse memberRegistrationResponse = memberService.registerMember(memberRegistrationRequest);
        return ResponseEntity.ok().body(memberRegistrationResponse);
    }
}
