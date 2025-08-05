import type { MemberRepository } from './MemberRepository';
import { Member } from './Member';
import ObjectID from 'bson-objectid';
import { v4 as uuidv4 } from 'uuid';

export class MemberService {
	constructor(private memberRepository: MemberRepository) {}

	/**
	 * Get all members
	 */
	async getAllMembers(): Promise<Member[]> {
		return await this.memberRepository.getAll();
	}

	/**
	 * Get member by ID
	 */
	async getById(id: string): Promise<Member | null> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}
		return await this.memberRepository.getById(id.trim());
	}

	/**
	 * Get member by email
	 */
	async getByEmail(email: string): Promise<Member | null> {
		if (!email || email.trim() === '') {
			throw new Error('Email is required');
		}
		return await this.memberRepository.getByEmail(email.trim());
	}

	/**
	 * Get member by UUID
	 */
	async getByUuid(uuid: string): Promise<Member | null> {
		if (!uuid || uuid.trim() === '') {
			throw new Error('UUID is required');
		}
		return await this.memberRepository.getByUuid(uuid.trim());
	}

	/**
	 * Get members by status
	 */
	async getMembersByStatus(status: string): Promise<Member[]> {
		if (!status || status.trim() === '') {
			throw new Error('Status is required');
		}

		const validStatuses = ['free', 'paid', 'comped'];
		if (!validStatuses.includes(status.trim())) {
			throw new Error(`Invalid status. Must be one of: ${validStatuses.join(', ')}`);
		}

		return await this.memberRepository.getByStatus(status.trim());
	}

	/**
	 * Create new member
	 */
	async createMember(data: {
		email: string;
		status?: string;
		name?: string | null;
		expertise?: string | null;
		note?: string | null;
		geolocation?: string | null;
		enableCommentNotifications?: boolean;
		createdBy: string;
	}): Promise<Member> {
		// Validate input
		if (!data.email || data.email.trim() === '') {
			throw new Error('Email is required');
		}
		if (!data.createdBy || data.createdBy.trim() === '') {
			throw new Error('CreatedBy is required');
		}

		// Check if email already exists
		const emailExists = await this.memberRepository.emailExists(data.email.trim());
		if (emailExists) {
			throw new Error(`Member with email '${data.email}' already exists`);
		}

		// Create new member
		const member = Member.create({
			id: new ObjectID().toHexString(),
			uuid: uuidv4(),
			email: data.email.trim(),
			status: data.status?.trim() || 'free',
			name: data.name?.trim() || null,
			expertise: data.expertise?.trim() || null,
			note: data.note?.trim() || null,
			geolocation: data.geolocation?.trim() || null,
			enableCommentNotifications: data.enableCommentNotifications ?? true,
			createdBy: data.createdBy.trim()
		});

		return await this.memberRepository.create(member);
	}

	/**
	 * Update member
	 */
	async updateMember(id: string, data: {
		name?: string | null;
		expertise?: string | null;
		note?: string | null;
		geolocation?: string | null;
		enableCommentNotifications?: boolean;
		status?: string;
		updatedBy: string;
	}): Promise<Member> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}
		if (!data.updatedBy || data.updatedBy.trim() === '') {
			throw new Error('UpdatedBy is required');
		}

		const existing = await this.memberRepository.getById(id.trim());
		if (!existing) {
			throw new Error(`Member with ID '${id}' not found`);
		}

		const updated = existing.update({
			name: data.name?.trim() || null,
			expertise: data.expertise?.trim() || null,
			note: data.note?.trim() || null,
			geolocation: data.geolocation?.trim() || null,
			enableCommentNotifications: data.enableCommentNotifications,
			status: data.status?.trim(),
			updatedBy: data.updatedBy.trim()
		});

		return await this.memberRepository.update(updated);
	}

	/**
	 * Update member activity
	 */
	async updateMemberActivity(id: string, data: {
		lastSeenAt?: Date | null;
		lastCommentedAt?: Date | null;
		emailCount?: number;
		emailOpenedCount?: number;
		emailOpenRate?: number | null;
		updatedBy: string;
	}): Promise<Member> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}
		if (!data.updatedBy || data.updatedBy.trim() === '') {
			throw new Error('UpdatedBy is required');
		}

		const existing = await this.memberRepository.getById(id.trim());
		if (!existing) {
			throw new Error(`Member with ID '${id}' not found`);
		}

		const updated = existing.updateActivity({
			lastSeenAt: data.lastSeenAt,
			lastCommentedAt: data.lastCommentedAt,
			emailCount: data.emailCount,
			emailOpenedCount: data.emailOpenedCount,
			emailOpenRate: data.emailOpenRate,
			updatedBy: data.updatedBy.trim()
		});

		return await this.memberRepository.update(updated);
	}

	/**
	 * Delete member by ID
	 */
	async deleteMember(id: string): Promise<void> {
		if (!id || id.trim() === '') {
			throw new Error('ID is required');
		}

		const existing = await this.memberRepository.getById(id.trim());
		if (!existing) {
			throw new Error(`Member with ID '${id}' not found`);
		}

		await this.memberRepository.deleteById(id.trim());
	}
}