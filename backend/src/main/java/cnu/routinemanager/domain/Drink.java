package cnu.routinemanager.domain;

import java.time.LocalDate;
import javax.persistence.*;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Drink {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    @Column
    private int amount;

    @Column
    private LocalDate date;

    public Drink(Member member, int amount, LocalDate date) {
        this.member = member;
        this.amount = amount;
        this.date = date;
    }
}
