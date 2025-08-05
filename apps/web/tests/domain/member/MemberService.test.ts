import { describe, it, expect, beforeEach, vi } from 'vitest';
import { Member } from '../../../src/domain/member/Member';
import { MemberService } from '../../../src/domain/member/MemberService';
import type { MemberRepository } from '../../../src/domain/member/MemberRepository';

// Mock MemberRepository
const mockMemberRepository: MemberRepository = {
	getAll: vi.fn(),
	getById: vi.fn(),
	getByEmail: vi.fn(),
	getByUuid: vi.fn(),
	getByStatus: vi.fn(),
	create: vi.fn(),
	update: vi.fn(),
	deleteById: vi.fn(),
	emailExists: vi.fn()
};

describe('MemberService', () => {
	let memberService: MemberService;

	beforeEach(() => {
		memberService = new MemberService(mockMemberRepository);
		vi.clearAllMocks();
	});

	describe('getAllMembers', () => {
		it('should return all members', async () => {
			// Arrange
			const expectedMembers = [
				Member.create({
					id: 'member-1',
					uuid: 'uuid-1',
					email: 'test1@example.com',
					createdBy: 'admin'
				}),
				Member.create({
					id: 'member-2',
					uuid: 'uuid-2',
					email: 'test2@example.com',
					createdBy: 'admin'
				})
			];
			vi.mocked(mockMemberRepository.getAll).mockResolvedValue(expectedMembers);

			// Act
			const result = await memberService.getAllMembers();

			// Assert
			expect(mockMemberRepository.getAll).toHaveBeenCalledOnce();
			expect(result).toEqual(expectedMembers);
		});
	});

	describe('getById', () => {
		it('should return member for valid ID', async () => {
			// Arrange
			const id = 'member-123';
			const expectedMember = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				createdBy: 'admin'
			});
			vi.mocked(mockMemberRepository.getById).mockResolvedValue(expectedMember);

			// Act
			const result = await memberService.getById(id);

			// Assert
			expect(mockMemberRepository.getById).toHaveBeenCalledWith(id);
			expect(result).toEqual(expectedMember);
		});

		it('should return null for non-existent ID', async () => {
			// Arrange
			vi.mocked(mockMemberRepository.getById).mockResolvedValue(null);

			// Act
			const result = await memberService.getById('non-existent');

			// Assert
			expect(result).toBeNull();
		});

		it('should throw error for empty ID', async () => {
			// Act & Assert
			await expect(memberService.getById('')).rejects.toThrow('ID is required');
			await expect(memberService.getById('   ')).rejects.toThrow('ID is required');
		});
	});

	describe('getByEmail', () => {
		it('should return member for valid email', async () => {
			// Arrange
			const email = 'test@example.com';
			const expectedMember = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				createdBy: 'admin'
			});
			vi.mocked(mockMemberRepository.getByEmail).mockResolvedValue(expectedMember);

			// Act
			const result = await memberService.getByEmail(email);

			// Assert
			expect(mockMemberRepository.getByEmail).toHaveBeenCalledWith(email);
			expect(result).toEqual(expectedMember);
		});

		it('should throw error for empty email', async () => {
			// Act & Assert
			await expect(memberService.getByEmail('')).rejects.toThrow('Email is required');
		});
	});

	describe('getByUuid', () => {
		it('should return member for valid UUID', async () => {
			// Arrange
			const uuid = 'uuid-123';
			const expectedMember = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				createdBy: 'admin'
			});
			vi.mocked(mockMemberRepository.getByUuid).mockResolvedValue(expectedMember);

			// Act
			const result = await memberService.getByUuid(uuid);

			// Assert
			expect(mockMemberRepository.getByUuid).toHaveBeenCalledWith(uuid);
			expect(result).toEqual(expectedMember);
		});

		it('should throw error for empty UUID', async () => {
			// Act & Assert
			await expect(memberService.getByUuid('')).rejects.toThrow('UUID is required');
		});
	});

	describe('getMembersByStatus', () => {
		it('should return members for valid status', async () => {
			// Arrange
			const status = 'paid';
			const expectedMembers = [
				Member.create({
					id: 'member-1',
					uuid: 'uuid-1',
					email: 'test1@example.com',
					status: 'paid',
					createdBy: 'admin'
				})
			];
			vi.mocked(mockMemberRepository.getByStatus).mockResolvedValue(expectedMembers);

			// Act
			const result = await memberService.getMembersByStatus(status);

			// Assert
			expect(mockMemberRepository.getByStatus).toHaveBeenCalledWith(status);
			expect(result).toEqual(expectedMembers);
		});

		it('should throw error for empty status', async () => {
			// Act & Assert
			await expect(memberService.getMembersByStatus('')).rejects.toThrow('Status is required');
		});

		it('should throw error for invalid status', async () => {
			// Act & Assert
			await expect(memberService.getMembersByStatus('invalid')).rejects.toThrow(
				'Invalid status. Must be one of: free, paid, comped'
			);
		});

		it('should accept valid status values', async () => {
			// Arrange
			vi.mocked(mockMemberRepository.getByStatus).mockResolvedValue([]);

			// Act & Assert
			await expect(memberService.getMembersByStatus('free')).resolves.not.toThrow();
			await expect(memberService.getMembersByStatus('paid')).resolves.not.toThrow();
			await expect(memberService.getMembersByStatus('comped')).resolves.not.toThrow();
		});
	});

	describe('createMember', () => {
		it('should create a new member successfully', async () => {
			// Arrange
			const memberData = {
				email: 'test@example.com',
				status: 'paid',
				name: 'John Doe',
				expertise: 'JavaScript',
				note: 'Expert developer',
				geolocation: 'US',
				enableCommentNotifications: false,
				createdBy: 'admin'
			};

			vi.mocked(mockMemberRepository.emailExists).mockResolvedValue(false);
			vi.mocked(mockMemberRepository.create).mockImplementation(async (member) => member);

			// Act
			const result = await memberService.createMember(memberData);

			// Assert
			expect(mockMemberRepository.emailExists).toHaveBeenCalledWith('test@example.com');
			expect(mockMemberRepository.create).toHaveBeenCalled();
			expect(result.email).toBe('test@example.com');
			expect(result.status).toBe('paid');
			expect(result.name).toBe('John Doe');
			expect(result.expertise).toBe('JavaScript');
		});

		it('should create member with default values', async () => {
			// Arrange
			const memberData = {
				email: 'test@example.com',
				createdBy: 'admin'
			};

			vi.mocked(mockMemberRepository.emailExists).mockResolvedValue(false);
			vi.mocked(mockMemberRepository.create).mockImplementation(async (member) => member);

			// Act
			const result = await memberService.createMember(memberData);

			// Assert
			expect(result.status).toBe('free'); // default status
			expect(result.enableCommentNotifications).toBe(true); // default value
			expect(result.name).toBeNull();
			expect(result.expertise).toBeNull();
		});

		it('should throw error if email already exists', async () => {
			// Arrange
			const memberData = {
				email: 'existing@example.com',
				createdBy: 'admin'
			};

			vi.mocked(mockMemberRepository.emailExists).mockResolvedValue(true);

			// Act & Assert
			await expect(memberService.createMember(memberData)).rejects.toThrow(
				"Member with email 'existing@example.com' already exists"
			);
		});

		it('should throw error for missing required fields', async () => {
			// Act & Assert
			await expect(memberService.createMember({
				email: '',
				createdBy: 'admin'
			})).rejects.toThrow('Email is required');

			await expect(memberService.createMember({
				email: 'test@example.com',
				createdBy: ''
			})).rejects.toThrow('CreatedBy is required');
		});

		it('should trim whitespace from input data', async () => {
			// Arrange
			const memberData = {
				email: '  test@example.com  ',
				name: '  John Doe  ',
				expertise: '  JavaScript  ',
				createdBy: '  admin  '
			};

			vi.mocked(mockMemberRepository.emailExists).mockResolvedValue(false);
			vi.mocked(mockMemberRepository.create).mockImplementation(async (member) => member);

			// Act
			const result = await memberService.createMember(memberData);

			// Assert
			expect(result.email).toBe('test@example.com');
			expect(result.name).toBe('John Doe');
			expect(result.expertise).toBe('JavaScript');
			expect(result.createdBy).toBe('admin');
		});

		it('should generate UUID for new member', async () => {
			// Arrange
			const memberData = {
				email: 'test@example.com',
				createdBy: 'admin'
			};

			vi.mocked(mockMemberRepository.emailExists).mockResolvedValue(false);
			vi.mocked(mockMemberRepository.create).mockImplementation(async (member) => member);

			// Act
			const result = await memberService.createMember(memberData);

			// Assert
			expect(result.uuid).toBeTruthy();
			expect(typeof result.uuid).toBe('string');
		});
	});

	describe('updateMember', () => {
		it('should update member successfully', async () => {
			// Arrange
			const id = 'member-123';
			const updateData = {
				name: 'Updated Name',
				expertise: 'TypeScript',
				status: 'paid',
				updatedBy: 'admin'
			};

			const existingMember = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				name: 'Original Name',
				createdBy: 'creator'
			});

			vi.mocked(mockMemberRepository.getById).mockResolvedValue(existingMember);
			vi.mocked(mockMemberRepository.update).mockImplementation(async (member) => member);

			// Act
			const result = await memberService.updateMember(id, updateData);

			// Assert
			expect(mockMemberRepository.getById).toHaveBeenCalledWith(id);
			expect(mockMemberRepository.update).toHaveBeenCalled();
			expect(result.name).toBe('Updated Name');
			expect(result.expertise).toBe('TypeScript');
			expect(result.status).toBe('paid');
			expect(result.updatedBy).toBe('admin');
		});

		it('should throw error if member not found', async () => {
			// Arrange
			vi.mocked(mockMemberRepository.getById).mockResolvedValue(null);

			// Act & Assert
			await expect(memberService.updateMember('non-existent', { updatedBy: 'admin' })).rejects.toThrow(
				"Member with ID 'non-existent' not found"
			);
		});

		it('should throw error for missing required fields', async () => {
			// Act & Assert
			await expect(memberService.updateMember('', { updatedBy: 'admin' })).rejects.toThrow('ID is required');
			await expect(memberService.updateMember('id', { updatedBy: '' })).rejects.toThrow('UpdatedBy is required');
		});
	});

	describe('updateMemberActivity', () => {
		it('should update member activity successfully', async () => {
			// Arrange
			const id = 'member-123';
			const activityData = {
				lastSeenAt: new Date(),
				lastCommentedAt: new Date(),
				emailCount: 10,
				emailOpenedCount: 7,
				emailOpenRate: 0.7,
				updatedBy: 'system'
			};

			const existingMember = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			vi.mocked(mockMemberRepository.getById).mockResolvedValue(existingMember);
			vi.mocked(mockMemberRepository.update).mockImplementation(async (member) => member);

			// Act
			const result = await memberService.updateMemberActivity(id, activityData);

			// Assert
			expect(mockMemberRepository.getById).toHaveBeenCalledWith(id);
			expect(mockMemberRepository.update).toHaveBeenCalled();
			expect(result.emailCount).toBe(10);
			expect(result.emailOpenedCount).toBe(7);
			expect(result.emailOpenRate).toBe(0.7);
			expect(result.updatedBy).toBe('system');
		});

		it('should throw error if member not found', async () => {
			// Arrange
			vi.mocked(mockMemberRepository.getById).mockResolvedValue(null);

			// Act & Assert
			await expect(memberService.updateMemberActivity('non-existent', { updatedBy: 'system' })).rejects.toThrow(
				"Member with ID 'non-existent' not found"
			);
		});
	});

	describe('deleteMember', () => {
		it('should delete member successfully', async () => {
			// Arrange
			const id = 'member-123';
			const existingMember = Member.create({
				id: 'member-123',
				uuid: 'uuid-123',
				email: 'test@example.com',
				createdBy: 'creator'
			});

			vi.mocked(mockMemberRepository.getById).mockResolvedValue(existingMember);
			vi.mocked(mockMemberRepository.deleteById).mockResolvedValue(undefined);

			// Act
			await memberService.deleteMember(id);

			// Assert
			expect(mockMemberRepository.getById).toHaveBeenCalledWith(id);
			expect(mockMemberRepository.deleteById).toHaveBeenCalledWith(id);
		});

		it('should throw error if member not found', async () => {
			// Arrange
			vi.mocked(mockMemberRepository.getById).mockResolvedValue(null);

			// Act & Assert
			await expect(memberService.deleteMember('non-existent')).rejects.toThrow(
				"Member with ID 'non-existent' not found"
			);
		});

		it('should throw error for empty ID', async () => {
			// Act & Assert
			await expect(memberService.deleteMember('')).rejects.toThrow('ID is required');
		});
	});
});