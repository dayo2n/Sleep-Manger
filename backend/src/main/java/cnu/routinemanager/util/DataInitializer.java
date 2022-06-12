package cnu.routinemanager.util;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import cnu.routinemanager.domain.GoalSleep;
import cnu.routinemanager.domain.Member;
import cnu.routinemanager.domain.Sleep;
import cnu.routinemanager.repository.DrinkNotificationTimeRepository;
import cnu.routinemanager.repository.DrinkRepository;
import cnu.routinemanager.repository.MemberRepository;
import cnu.routinemanager.repository.SleepRepository;

@Component
public class DataInitializer implements ApplicationRunner {
    private final MemberRepository memberRepository;
    private final SleepRepository sleepRepository;
    private final DrinkNotificationTimeRepository drinkNotificationTimeRepository;
    private final DrinkRepository drinkRepository;

    public DataInitializer(MemberRepository memberRepository, SleepRepository sleepRepository, DrinkNotificationTimeRepository drinkNotificationTimeRepository, DrinkRepository drinkRepository) {
        this.memberRepository = memberRepository;
        this.sleepRepository = sleepRepository;
        this.drinkNotificationTimeRepository = drinkNotificationTimeRepository;
        this.drinkRepository = drinkRepository;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        Member member = new Member(1L, "taewankim@naver.com");

        GoalSleep goalSleep = new GoalSleep(
                LocalTime.of(23, 0),
                LocalTime.of(7, 0),
                LocalTime.of(23, 0),
                LocalTime.of(9, 0)
        );

        member.setGoalSleep(goalSleep);
        memberRepository.save(member);

        Sleep sleep = new Sleep(
                1L,
                member,
                LocalTime.of(23, 0),
                LocalTime.of(8, 0),
                LocalDate.of(2022, 6, 9)
        );

        sleepRepository.save(sleep);
    }
}
