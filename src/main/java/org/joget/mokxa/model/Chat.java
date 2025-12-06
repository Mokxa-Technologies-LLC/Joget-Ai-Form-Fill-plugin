package org.joget.mokxa.model;

import com.google.gson.annotations.SerializedName;
import java.util.List;

public class Chat {
   private String model;
   private List<ChatGptMessage> messages;
   private ResponseFormat response_format;
   @SerializedName("max_tokens")
   private int maxTokens;

   public String getModel() {
      return this.model;
   }

   public void setModel(String model) {
      this.model = model;
   }

   public List<ChatGptMessage> getMessages() {
      return this.messages;
   }

   public void setMessages(List<ChatGptMessage> messages) {
      this.messages = messages;
   }

   public int getMaxTokens() {
      return this.maxTokens;
   }

   public void setMaxTokens(int maxTokens) {
      this.maxTokens = maxTokens;
   }

   public void setResponseFormat(ResponseFormat response_format) {
      this.response_format = response_format;
   }
}
