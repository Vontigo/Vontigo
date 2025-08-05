import { eq, and, ne } from 'drizzle-orm';
import type { DrizzleDB } from '../db/drizzleClient';
import type { MemberRepository } from '../../domain/member/MemberRepository';
import { Member } from '../../domain/member/Member';
import { members, membersSqlite } from '../db/schema/membership';
import { DATABASE_TYPE } from '$env/static/private';

export class DrizzleMemberRepository implements MemberRepository {
	constructor(private db: DrizzleDB) {}

	private get table() {
		return DATABASE_TYPE === 'development' || DATABASE_TYPE === 'sqlite' 
			? membersSqlite 
			: members;
	}

	async getAll(): Promise<Member[]> {
		const results = await this.db
			.select()
			.from(this.table)
			.orderBy(this.table.createdAt);

		return results.map(this.mapToEntity);
	}

	async getById(id: string): Promise<Member | null> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.id, id))
			.limit(1);

		if (results.length === 0) {
			return null;
		}

		return this.mapToEntity(results[0]);
	}

	async getByEmail(email: string): Promise<Member | null> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.email, email))
			.limit(1);

		if (results.length === 0) {
			return null;
		}

		return this.mapToEntity(results[0]);
	}

	async getByUuid(uuid: string): Promise<Member | null> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.uuid, uuid))
			.limit(1);

		if (results.length === 0) {
			return null;
		}

		return this.mapToEntity(results[0]);
	}

	async getByStatus(status: string): Promise<Member[]> {
		const results = await this.db
			.select()
			.from(this.table)
			.where(eq(this.table.status, status))
			.orderBy(this.table.createdAt);

		return results.map(this.mapToEntity);
	}

	async create(member: Member): Promise<Member> {
		const data = this.mapToTable(member);
		
		await this.db.insert(this.table).values(data);
		
		// Return the created member
		const created = await this.getById(member.id);
		if (!created) {
			throw new Error('Failed to create member');
		}
		return created;
	}

	async update(member: Member): Promise<Member> {
		const data = this.mapToTable(member);
		
		await this.db
			.update(this.table)
			.set(data)
			.where(eq(this.table.id, member.id));
		
		// Return the updated member
		const updated = await this.getById(member.id);
		if (!updated) {
			throw new Error('Failed to update member');
		}
		return updated;
	}

	async deleteById(id: string): Promise<void> {
		await this.db
			.delete(this.table)
			.where(eq(this.table.id, id));
	}

	async emailExists(email: string, excludeId?: string): Promise<boolean> {
		const query = this.db
			.select({ id: this.table.id })
			.from(this.table)
			.where(eq(this.table.email, email));

		if (excludeId) {
			query.where(and(eq(this.table.email, email), ne(this.table.id, excludeId)));
		}

		const results = await query.limit(1);
		return results.length > 0;
	}

	private mapToEntity(row: any): Member {
		return new Member(
			row.id,
			row.uuid,
			row.email,
			row.status,
			row.name,
			row.expertise,
			row.note,
			row.geolocation,
			row.enableCommentNotifications,
			row.emailCount,
			row.emailOpenedCount,
			row.emailOpenRate,
			row.lastSeenAt ? new Date(row.lastSeenAt) : null,
			row.lastCommentedAt ? new Date(row.lastCommentedAt) : null,
			new Date(row.createdAt),
			row.createdBy,
			row.updatedAt ? new Date(row.updatedAt) : null,
			row.updatedBy
		);
	}

	private mapToTable(member: Member) {
		return {
			id: member.id,
			uuid: member.uuid,
			email: member.email,
			status: member.status,
			name: member.name,
			expertise: member.expertise,
			note: member.note,
			geolocation: member.geolocation,
			enableCommentNotifications: member.enableCommentNotifications,
			emailCount: member.emailCount,
			emailOpenedCount: member.emailOpenedCount,
			emailOpenRate: member.emailOpenRate,
			lastSeenAt: member.lastSeenAt,
			lastCommentedAt: member.lastCommentedAt,
			createdAt: member.createdAt,
			createdBy: member.createdBy,
			updatedAt: member.updatedAt,
			updatedBy: member.updatedBy
		};
	}
}