import type { Member } from './Member';

export interface MemberRepository {
	/**
	 * Get all members
	 */
	getAll(): Promise<Member[]>;

	/**
	 * Get member by ID
	 */
	getById(id: string): Promise<Member | null>;

	/**
	 * Get member by email
	 */
	getByEmail(email: string): Promise<Member | null>;

	/**
	 * Get member by UUID
	 */
	getByUuid(uuid: string): Promise<Member | null>;

	/**
	 * Get members by status
	 */
	getByStatus(status: string): Promise<Member[]>;

	/**
	 * Create new member
	 */
	create(member: Member): Promise<Member>;

	/**
	 * Update member
	 */
	update(member: Member): Promise<Member>;

	/**
	 * Delete member by ID
	 */
	deleteById(id: string): Promise<void>;

	/**
	 * Check if email exists
	 */
	emailExists(email: string, excludeId?: string): Promise<boolean>;
}