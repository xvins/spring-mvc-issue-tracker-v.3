package com.springapp.mvc.service;

import com.springapp.mvc.model.Issue;
import com.springapp.mvc.model.Role;
import com.springapp.mvc.model.User;
import com.springapp.mvc.repository.IssueRepository;
import com.springapp.mvc.repository.RoleRepository;
import com.springapp.mvc.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private IssueRepository issueRepository;

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findOne(long id) {
        return userRepository.findOne(id);
    }

    public void save(User user) {
        user.setEnabled(true);
        List<Role> roles = new ArrayList<Role>();
        roles.add(roleRepository.findByName("ROLE_USER"));
        user.setRoles(roles);
        userRepository.save(user);
    }

    @Transactional
    public User findOneWithIssues(long id) {
        User user = findOne(id);
        List<Issue> issues = issueRepository.findByUser(user);
        user.setIssues(issues);
        return user;
    }

    public User findOneWithIssues(String name) {
        User user = userRepository.findByName(name);
        return findOneWithIssues(user.getId());
    }

}
