package cnu.routinemanager.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.dto.response.GoalSleepResponse;
import cnu.routinemanager.domain.GoalSleep;
import cnu.routinemanager.domain.Member;

@Service
public class GoalSleepService {
    private final MemberService memberService;

    public GoalSleepService(MemberService memberService) {
        this.memberService = memberService;
    }

    @Transactional(readOnly = true)
    public GoalSleepResponse findGoalSleepTime(Long id) {
        Member member = memberService.findById(id);
        GoalSleep goalSleep = member.getGoalSleep();
        return new GoalSleepResponse(goalSleep.getGoalWakeUpTime(), goalSleep.getGoalBedTime());
    }
}
