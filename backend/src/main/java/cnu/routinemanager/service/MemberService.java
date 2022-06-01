package cnu.routinemanager.service;

import javax.persistence.EntityNotFoundException;
import javax.validation.Valid;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.dto.request.MemberRegistrationRequest;
import cnu.routinemanager.dto.response.MemberRegistrationResponse;
import cnu.routinemanager.domain.Member;
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

    public Member findById(long id) {
        return memberRepository.findById(id)
                               .orElseThrow(() -> new EntityNotFoundException("존재하지 않는 멤버입니다."));
    }
}
