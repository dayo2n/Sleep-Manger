package cnu.routinemanager.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import cnu.routinemanager.entity.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

}
