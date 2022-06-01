package cnu.routinemanager.service;

import javax.validation.Valid;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.dto.request.MemberRegistrationRequest;
import cnu.routinemanager.dto.response.MemberRegistrationResponse;
import cnu.routinemanager.entity.Member;
import cnu.routinemanager.repository.MemberRepository;

@Service
public class MemberService {
    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Transactional
    public MemberRegistrationResponse registerMember(@Valid MemberRegistrationRequest memberRegistrationRequest) {
        Member member = new Member(memberRegistrationRequest.getEmail());
        Member savedMember = memberRepository.save(member);
        return new MemberRegistrationResponse(savedMember.getId(), savedMember.getEmail());
    }
}
