package com.crawlstars.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@RequiredArgsConstructor
public class Posts {
private String post_id;
@NonNull
private String post_title;
private String pl_id;
private String pl_title;
@NonNull
private String sp_id;
@NonNull
private String post_body;
private String post_img;
private String created_at;
private String updated_at;

}
