import { describe, it, expect, beforeEach, vi } from 'vitest';
import { User } from '../../../src/domain/user/User';
import { UserService } from '../../../src/domain/user/UserService';
import type { UserRepository } from '../../../src/domain/user/UserRepository';

// Mock UserRepository
const mockUserRepository: UserRepository = {
	findById: vi.fn(),
	findByEmail: vi.fn(),
	findBySlug: vi.fn(),
	save: vi.fn(),
	create: vi.fn(),
	update: vi.fn(),
	delete: vi.fn(),
	findAll: vi.fn(),
	count: vi.fn(),
	existsByEmail: vi.fn(),
	existsBySlug: vi.fn()
};

describe('UserService', () => {
	let userService: UserService;

	beforeEach(() => {
		userService = new UserService(mockUserRepository);
		vi.clearAllMocks();
	});

	describe('createUser', () => {
		it('should create a new user successfully', async () => {
			// Arrange
			const userData = {
				name: 'John Doe',
				email: 'john@example.com',
				password: 'hashedpassword123',
				slug: 'john-doe'
			};

			const expectedUser = User.create({
				id: 'test-id-123',
				name: userData.name,
				email: userData.email,
				password: userData.password,
				slug: userData.slug
			});

			vi.mocked(mockUserRepository.existsByEmail).mockResolvedValue(false);
			vi.mocked(mockUserRepository.existsBySlug).mockResolvedValue(false);
			vi.mocked(mockUserRepository.create).mockResolvedValue(expectedUser);

			// Act
			const result = await userService.createUser(userData);

			// Assert
			expect(mockUserRepository.existsByEmail).toHaveBeenCalledWith(userData.email);
			expect(mockUserRepository.create).toHaveBeenCalled();
			expect(result.name).toBe(userData.name);
			expect(result.email).toBe(userData.email);
		});

		it('should throw error if email already exists', async () => {
			// Arrange
			const userData = {
				name: 'John Doe',
				email: 'john@example.com',
				password: 'hashedpassword123'
			};

			vi.mocked(mockUserRepository.existsByEmail).mockResolvedValue(true);

			// Act & Assert
			await expect(userService.createUser(userData)).rejects.toThrow(
				'User with this email already exists'
			);
		});

		it('should generate unique slug when slug conflicts exist', async () => {
			// Arrange
			const userData = {
				name: 'John Doe',
				email: 'john@example.com',
				password: 'hashedpassword123'
			};

			vi.mocked(mockUserRepository.existsByEmail).mockResolvedValue(false);
			vi.mocked(mockUserRepository.existsBySlug)
				.mockResolvedValueOnce(true) // first slug exists
				.mockResolvedValueOnce(false); // second slug is unique

			vi.mocked(mockUserRepository.create).mockImplementation(async (user) => user);

			// Act
			const result = await userService.createUser(userData);

			// Assert
			expect(mockUserRepository.existsBySlug).toHaveBeenCalledTimes(2);
			expect(result.slug).toBe('john-doe-1'); // Should have incremented
		});
	});

	describe('getUserById', () => {
		it('should return user when found', async () => {
			// Arrange
			const userId = 'test-id-123';
			const expectedUser = User.create({
				id: userId,
				name: 'John Doe',
				email: 'john@example.com',
				password: 'password',
				slug: 'john-doe'
			});

			vi.mocked(mockUserRepository.findById).mockResolvedValue(expectedUser);

			// Act
			const result = await userService.getUserById(userId);

			// Assert
			expect(mockUserRepository.findById).toHaveBeenCalledWith(userId);
			expect(result).toBe(expectedUser);
		});

		it('should return null when user not found', async () => {
			// Arrange
			const userId = 'non-existent-id';
			vi.mocked(mockUserRepository.findById).mockResolvedValue(null);

			// Act
			const result = await userService.getUserById(userId);

			// Assert
			expect(result).toBeNull();
		});
	});

	describe('updateUser', () => {
		it('should update user successfully', async () => {
			// Arrange
			const userId = 'test-id-123';
			const existingUser = User.create({
				id: userId,
				name: 'John Doe',
				email: 'john@example.com',
				password: 'password',
				slug: 'john-doe'
			});

			const updates = {
				name: 'John Smith',
				bio: 'Updated bio'
			};

			vi.mocked(mockUserRepository.findById).mockResolvedValue(existingUser);
			vi.mocked(mockUserRepository.update).mockImplementation(async (user) => user);

			// Act
			const result = await userService.updateUser(userId, updates);

			// Assert
			expect(mockUserRepository.findById).toHaveBeenCalledWith(userId);
			expect(mockUserRepository.update).toHaveBeenCalled();
			expect(result.name).toBe(updates.name);
		});

		it('should throw error when user not found', async () => {
			// Arrange
			const userId = 'non-existent-id';
			vi.mocked(mockUserRepository.findById).mockResolvedValue(null);

			// Act & Assert
			await expect(userService.updateUser(userId, { name: 'New Name' })).rejects.toThrow(
				'User not found'
			);
		});
	});
});