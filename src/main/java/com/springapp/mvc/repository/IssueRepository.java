


package com.springapp.mvc.repository;

import com.springapp.mvc.model.Issue;
import com.springapp.mvc.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("issueRepository")
public interface IssueRepository extends JpaRepository<Issue, Long> {

    List<Issue> findByUser(User user);

}