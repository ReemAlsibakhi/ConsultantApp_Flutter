abstract class  InboxRepository {
  createInbox(String subject,String description,int senderId,String archiveNo, String archiveDate, String? decission,
      int statusId, String? finalDecision, String? tags, String activities );
}