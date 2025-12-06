package org.joget.mokxa.model;

import com.google.gson.annotations.SerializedName;
import java.util.List;

public class ChatGptMessage {
   private String role;
   private List<Content> content;

   public String getRole() {
      return this.role;
   }

   public void setRole(String role) {
      this.role = role;
   }

   public List<Content> getContent() {
      return this.content;
   }

   public void setContent(List<Content> content) {
      this.content = content;
   }

   public static class Content {
      private String type;
      private String text = null;
      @SerializedName("image_url")
      private ImageUrl imageUrl = null;

      public String getType() {
         return this.type;
      }

      public void setType(String type) {
         this.type = type;
      }

      public String getText() {
         return this.text;
      }

      public void setText(String text) {
         this.text = text;
      }

      public ImageUrl getImageUrl() {
         return this.imageUrl;
      }

      public void setImageUrl(ImageUrl imageUrl) {
         this.imageUrl = imageUrl;
      }
   }

   public static class ImageUrl {
      private String url;

      public String getUrl() {
         return this.url;
      }

      public void setUrl(String url) {
         this.url = url;
      }
   }
}
