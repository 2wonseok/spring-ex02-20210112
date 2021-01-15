package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	private long cno;
	private long bno;
	private String content;
	private String writer;
	private Date reggate;
	private Date updatedate;
}
