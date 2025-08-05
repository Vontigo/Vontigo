import { z } from 'zod';
import { TagSlugSchema, TagNameSchema } from '../../infrastructure/db/schema/tag';

export class Tag {
	constructor(
		public readonly id: string,
		public readonly name: string,
		public readonly slug: string,
		public readonly description: string | null,
		public readonly featureImage: string | null,
		public readonly visibility: string,
		public readonly ogImage: string | null,
		public readonly ogTitle: string | null,
		public readonly ogDescription: string | null,
		public readonly twitterImage: string | null,
		public readonly twitterTitle: string | null,
		public readonly twitterDescription: string | null,
		public readonly metaTitle: string | null,
		public readonly metaDescription: string | null,
		public readonly codeinjectionHead: string | null,
		public readonly codeinjectionFoot: string | null,
		public readonly canonicalUrl: string | null,
		public readonly accentColor: string | null,
		public readonly createdAt: Date,
		public readonly createdBy: string,
		public readonly updatedAt: Date | null,
		public readonly updatedBy: string | null
	) {
		// Validate domain invariants
		this.validateName(name);
		this.validateSlug(slug);
	}

	private validateName(name: string): void {
		const result = TagNameSchema.safeParse(name);
		if (!result.success) {
			throw new Error(`Invalid tag name: ${result.error.message}`);
		}
	}

	private validateSlug(slug: string): void {
		const result = TagSlugSchema.safeParse(slug);
		if (!result.success) {
			throw new Error(`Invalid tag slug: ${result.error.message}`);
		}
	}

	/**
	 * Create a new Tag instance
	 */
	static create(data: {
		id: string;
		name: string;
		slug: string;
		description?: string | null;
		featureImage?: string | null;
		visibility?: string;
		createdBy: string;
	}): Tag {
		return new Tag(
			data.id,
			data.name,
			data.slug,
			data.description ?? null,
			data.featureImage ?? null,
			data.visibility ?? 'public',
			null, // ogImage
			null, // ogTitle
			null, // ogDescription
			null, // twitterImage
			null, // twitterTitle
			null, // twitterDescription
			null, // metaTitle
			null, // metaDescription
			null, // codeinjectionHead
			null, // codeinjectionFoot
			null, // canonicalUrl
			null, // accentColor
			new Date(),
			data.createdBy,
			null,
			null
		);
	}

	/**
	 * Update tag information
	 */
	update(data: {
		name?: string;
		slug?: string;
		description?: string | null;
		featureImage?: string | null;
		visibility?: string;
		updatedBy: string;
	}): Tag {
		const name = data.name ?? this.name;
		const slug = data.slug ?? this.slug;
		
		// Validate if changed
		if (data.name && data.name !== this.name) {
			this.validateName(name);
		}
		if (data.slug && data.slug !== this.slug) {
			this.validateSlug(slug);
		}

		return new Tag(
			this.id,
			name,
			slug,
			data.description ?? this.description,
			data.featureImage ?? this.featureImage,
			data.visibility ?? this.visibility,
			this.ogImage,
			this.ogTitle,
			this.ogDescription,
			this.twitterImage,
			this.twitterTitle,
			this.twitterDescription,
			this.metaTitle,
			this.metaDescription,
			this.codeinjectionHead,
			this.codeinjectionFoot,
			this.canonicalUrl,
			this.accentColor,
			this.createdAt,
			this.createdBy,
			new Date(),
			data.updatedBy
		);
	}

	/**
	 * Convert to plain object for serialization
	 */
	toJSON() {
		return {
			id: this.id,
			name: this.name,
			slug: this.slug,
			description: this.description,
			featureImage: this.featureImage,
			visibility: this.visibility,
			ogImage: this.ogImage,
			ogTitle: this.ogTitle,
			ogDescription: this.ogDescription,
			twitterImage: this.twitterImage,
			twitterTitle: this.twitterTitle,
			twitterDescription: this.twitterDescription,
			metaTitle: this.metaTitle,
			metaDescription: this.metaDescription,
			codeinjectionHead: this.codeinjectionHead,
			codeinjectionFoot: this.codeinjectionFoot,
			canonicalUrl: this.canonicalUrl,
			accentColor: this.accentColor,
			createdAt: this.createdAt,
			createdBy: this.createdBy,
			updatedAt: this.updatedAt,
			updatedBy: this.updatedBy
		};
	}
}