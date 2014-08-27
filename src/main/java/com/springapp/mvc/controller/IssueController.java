
package com.springapp.mvc.controller;

import com.springapp.mvc.model.Issue;
import com.springapp.mvc.repository.IssueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
import java.util.Date;

@Controller
public class IssueController {


    @Autowired
    private IssueRepository issueRepository;

    @ModelAttribute("issue")
    public Issue construct() {
        return new Issue();
    }

    @RequestMapping("/")
    public String issues(ModelMap model) {
        model.addAttribute("issues", issueRepository.findAll());
        return "issues";
    }

    @RequestMapping("/create")
    public String showCreateForm() {
        return "create";
    }

    @RequestMapping(value="/create", method= RequestMethod.POST)
    public String createIssue(@ModelAttribute("issue") Issue issue, BindingResult result) {
        issue.setDate(new Date());
        issue.setStatus("Created");
        issueRepository.save(issue);
        return "redirect:/";
    }

//    @RequestMapping("/users/{id}")
//    public String userDetail(ModelMap model, @PathVariable long id) {
//        model.addAttribute("user", userRepository.findOne(id));
//        return "user-detail";
//    }

//    @Autowired
//    private IssueRepository issueRepository;
//
//    @RequestMapping(value = "/", method = RequestMethod.GET)
//    public String listIssues(ModelMap model) {
//        model.addAttribute("issue", new Issue());
//        model.addAttribute("issues", issueRepository.findAll());
//        return "issues";
//    }
//
//    @RequestMapping(value = "/create", method = RequestMethod.POST)
//    public String addIssue(@ModelAttribute("issue") Issue issue, BindingResult result) {
//        issue.setStatus("Created");
//        issue.setDate(new Date());
//        issueRepository.save(issue);
//        return "redirect:/";
//    }
//
////    @RequestMapping(value = "/comment{id}", method = RequestMethod.GET)
////    public String commentIssue(@PathVariable Long id, Model model) {
////        model.addAttribute("issue", issueRepository.findOne(id));
////        return "comment";
////    }
//
//    @RequestMapping("/delete/{issueId}")
//    public String deleteUser(@PathVariable("issueId") Long issueId) {
//
//        issueRepository.delete(issueRepository.findOne(issueId));
//
//        return "redirect:/";
//    }
}