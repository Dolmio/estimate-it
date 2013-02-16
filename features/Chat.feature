Feature: Chat
  In order to communicate with other planners
  As a user
  I want a way to chat with others in the same url
  
  @javascript
  Scenario: chatting between two users
    Given Pekka and Matti are at the same url
    When Pekka writes specific text to the chat
    Then Matti should see specific text
    
  @javascript
  Scenario: User tries to chat with empty message
      Given Pekka and Matti are at the same url
      When Pekka tries to send empty message to the chat
      Then Pekka cant send the message
  
  @javascript
  Scenario: User tries to chat with empty nickname
      Given Pekka and Matti are at the same url
      When Pekka tries to send message without username to the chat
      Then Pekka cant send the message
  
  
  
  

  
