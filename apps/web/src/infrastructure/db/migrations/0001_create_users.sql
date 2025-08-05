CREATE TABLE IF NOT EXISTS "user_status" (
	"value" text PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_visibility" (
	"value" text PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"id" varchar(24) PRIMARY KEY NOT NULL,
	"name" varchar(191) NOT NULL,
	"slug" varchar(191) NOT NULL,
	"password" varchar(60) NOT NULL,
	"email" varchar(191) NOT NULL,
	"profile_image" varchar(2000),
	"cover_image" varchar(2000),
	"bio" text,
	"website" varchar(2000),
	"location" text,
	"facebook" varchar(2000),
	"twitter" varchar(2000),
	"accessibility" text,
	"status" "user_status" DEFAULT 'active' NOT NULL,
	"locale" varchar(6),
	"visibility" "user_visibility" DEFAULT 'public' NOT NULL,
	"meta_title" varchar(2000),
	"meta_description" varchar(2000),
	"tour" text,
	"last_seen" timestamp,
	"comment_notifications" boolean DEFAULT true NOT NULL,
	"free_member_signup_notification" boolean DEFAULT true NOT NULL,
	"paid_subscription_started_notification" boolean DEFAULT true NOT NULL,
	"paid_subscription_canceled_notification" boolean DEFAULT false NOT NULL,
	"mention_notifications" boolean DEFAULT true NOT NULL,
	"milestone_notifications" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"created_by" varchar(24) NOT NULL,
	"updated_at" timestamp,
	"updated_by" varchar(24),
	CONSTRAINT "users_slug_unique" UNIQUE("slug"),
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('active');
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('inactive');
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('locked');
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('warn-1');
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('warn-2');
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('warn-3');
--> statement-breakpoint
INSERT INTO "user_status" ("value") VALUES ('warn-4');
--> statement-breakpoint
INSERT INTO "user_visibility" ("value") VALUES ('public');