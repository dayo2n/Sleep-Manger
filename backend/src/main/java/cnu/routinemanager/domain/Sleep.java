package cnu.routinemanager.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import javax.persistence.*;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Sleep {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    @Column
    private LocalTime bedTime;

    @Column
    private LocalTime wakeUpTime;

    @Column
    private LocalDate date;

    public Sleep(Member member, LocalTime bedTime, LocalTime wakeUpTime, LocalDate date) {
        this.member = member;
        this.bedTime = bedTime;
        this.wakeUpTime = wakeUpTime;
        this.date = date;
    }
}
