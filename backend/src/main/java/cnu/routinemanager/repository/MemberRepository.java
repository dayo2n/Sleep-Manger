package cnu.routinemanager.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import cnu.routinemanager.domain.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

}
