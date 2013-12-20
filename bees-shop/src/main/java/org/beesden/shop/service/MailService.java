package org.beesden.shop.service;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailService {

	private JavaMailSender mailSender;

	public void sendMail(Map<String, Object> config, String subject, String body) {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			mimeMessage.setContent(body, "text/html");
			helper.setTo((InternetAddress) config.get("enquiryEmail"));
			helper.setFrom((InternetAddress) config.get("enquiryEmail"));
			helper.setSubject(subject);
			helper.setFrom("Website");
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			throw new MailParseException(e);
		}
	}

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
}