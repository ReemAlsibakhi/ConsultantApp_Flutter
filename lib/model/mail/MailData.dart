import 'Activities.dart';
import 'Attachments.dart';
import 'Sender.dart';
import 'Status.dart';
import 'Tags.dart';

class MailData {
  MailData({
    this.id,
    this.subject,
    this.description,
    this.senderId,
    this.archiveNumber,
    this.archiveDate,
    this.decision,
    this.statusId,
    this.finalDecision,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.status,
    this.tags,
    this.attachments,
    this.activities,
  });

  MailData.fromJson(dynamic json) {
    id = json['id'];
    subject = json['subject'];
    description = json['description'];
    senderId = json['sender_id'];
    archiveNumber = json['archive_number'];
    archiveDate = json['archive_date'];
    decision = json['decision'];
    statusId = json['status_id'];
    finalDecision = json['final_decision'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities!.add(Activities.fromJson(v));
      });
    }
  }
  int? id;
  String? subject;
  String? description;
  String? senderId;
  String? archiveNumber;
  String? archiveDate;
  String? decision;
  String? statusId;
  String? finalDecision;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Status? status;
  List<Tags>? tags;
  List<Attachments>? attachments;
  List<Activities>? activities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subject'] = subject;
    map['description'] = description;
    map['sender_id'] = senderId;
    map['archive_number'] = archiveNumber;
    map['archive_date'] = archiveDate;
    map['decision'] = decision;
    map['status_id'] = statusId;
    map['final_decision'] = finalDecision;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (sender != null) {
      map['sender'] = sender!.toJson();
    }
    if (status != null) {
      map['status'] = status!.toJson();
    }
    if (tags != null) {
      map['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (attachments != null) {
      map['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    if (activities != null) {
      map['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'MailData{id: $id, subject: $subject, description: $description, senderId: $senderId, archiveNumber: $archiveNumber, archiveDate: $archiveDate, decision: $decision, statusId: $statusId, finalDecision: $finalDecision, createdAt: $createdAt, updatedAt: $updatedAt, sender: $sender, status: $status, tags: $tags, attachments: $attachments, activities: $activities}';
  }
}
