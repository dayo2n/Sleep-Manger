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
    // member, 섭취량, 날짜
    public Drink(Member member, int amount, LocalDate date) {
        this.member = member;
        this.amount = amount;
        this.date = date;
    }

    // 같은 날짜가 이미 존재하는지
    public boolean hasSameDate(LocalDate date) {
        return this.date.equals(date);
    }

    // 기존 섭취량에 새로 들어온 섭취량을 더해줌
    public void addAmount(int amount) {
        this.amount += amount;
    }

    // 기존 섭취량을 무시하고 새로 입력된 섭취량으로 수정
    public void modifyAmount(int amount) {
        this.amount = amount;
    }
}
