#!/usr/bin/env node

/**
 * Migration script to help transition from Knex to Drizzle
 * 
 * This script helps identify and migrate existing Knex usage to Drizzle patterns
 */

import { readdir, readFile, writeFile } from 'fs/promises';
import { join } from 'path';

const SRC_DIR = './src';
const ROUTES_DIR = './src/routes';

// Patterns to identify Knex usage
const KNEX_PATTERNS = [
  /knexInstance/g,
  /knex\(/g,
  /\.select\(/g,
  /\.from\(/g,
  /\.where\(/g,
  /\.insert\(/g,
  /\.update\(/g,
  /\.delete\(/g,
  /\.leftJoin\(/g,
  /\.rightJoin\(/g,
  /\.innerJoin\(/g
];

async function findKnexUsage(dir: string): Promise<Array<{ file: string; matches: string[] }>> {
  const results: Array<{ file: string; matches: string[] }> = [];
  
  try {
    const entries = await readdir(dir, { withFileTypes: true });
    
    for (const entry of entries) {
      const fullPath = join(dir, entry.name);
      
      if (entry.isDirectory()) {
        const subResults = await findKnexUsage(fullPath);
        results.push(...subResults);
      } else if (entry.name.endsWith('.ts') || entry.name.endsWith('.js')) {
        const content = await readFile(fullPath, 'utf-8');
        const matches: string[] = [];
        
        for (const pattern of KNEX_PATTERNS) {
          const found = content.match(pattern);
          if (found) {
            matches.push(...found);
          }
        }
        
        if (matches.length > 0) {
          results.push({ file: fullPath, matches });
        }
      }
    }
  } catch (error) {
    console.error(`Error reading directory ${dir}:`, error);
  }
  
  return results;
}

async function generateMigrationReport() {
  console.log('🔍 Scanning for Knex usage...\n');
  
  const knexUsage = await findKnexUsage(SRC_DIR);
  
  if (knexUsage.length === 0) {
    console.log('✅ No Knex usage found!');
    return;
  }
  
  console.log(`📊 Found Knex usage in ${knexUsage.length} files:\n`);
  
  const report = ['# Knex to Drizzle Migration Report\n'];
  report.push(`Generated: ${new Date().toISOString()}\n`);
  report.push(`Files to migrate: ${knexUsage.length}\n`);
  
  for (const { file, matches } of knexUsage) {
    console.log(`📄 ${file}`);
    console.log(`   Patterns found: ${matches.length}`);
    console.log(`   ${matches.slice(0, 3).join(', ')}${matches.length > 3 ? '...' : ''}\n`);
    
    report.push(`## ${file}\n`);
    report.push(`Patterns found: ${matches.length}\n`);
    report.push('```typescript');
    report.push(matches.join('\n'));
    report.push('```\n');
  }
  
  // Migration suggestions
  report.push('\n## Migration Suggestions\n');
  report.push('1. **API Routes**: Update to use Container and domain services');
  report.push('2. **Database Queries**: Replace with Drizzle type-safe queries');
  report.push('3. **Raw SQL**: Convert to Drizzle query builder');
  report.push('4. **Transactions**: Use Drizzle transaction syntax\n');
  
  report.push('## Example Conversions\n');
  report.push('### Before (Knex)');
  report.push('```typescript');
  report.push('const users = await knexInstance.select().from("users").where({ status: "active" });');
  report.push('```\n');
  report.push('### After (Drizzle)');
  report.push('```typescript');
  report.push('const users = await db.select().from(usersTable).where(eq(usersTable.status, "active"));');
  report.push('```\n');
  
  await writeFile('./MIGRATION_REPORT.md', report.join('\n'));
  console.log('📝 Migration report saved to MIGRATION_REPORT.md');
}

// Priority files that should be migrated first
const HIGH_PRIORITY_PATTERNS = [
  '/api/admin/',
  '/api/content/',
  '/api/database/'
];

async function suggestMigrationOrder() {
  console.log('\n📋 Suggested Migration Order:\n');
  
  const knexUsage = await findKnexUsage(SRC_DIR);
  
  // Categorize files by priority
  const highPriority = knexUsage.filter(({ file }) => 
    HIGH_PRIORITY_PATTERNS.some(pattern => file.includes(pattern))
  );
  
  const lowPriority = knexUsage.filter(({ file }) => 
    !HIGH_PRIORITY_PATTERNS.some(pattern => file.includes(pattern))
  );
  
  console.log('🔴 High Priority (API endpoints):');
  highPriority.forEach(({ file, matches }) => {
    console.log(`   • ${file} (${matches.length} patterns)`);
  });
  
  console.log('\n🟡 Medium Priority (other files):');
  lowPriority.forEach(({ file, matches }) => {
    console.log(`   • ${file} (${matches.length} patterns)`);
  });
  
  console.log('\n💡 Recommendations:');
  console.log('1. Start with API endpoints to get immediate benefits');
  console.log('2. Create domain services for business logic');
  console.log('3. Migrate data access patterns to repositories');
  console.log('4. Add tests for each migrated component');
  console.log('5. Update documentation');
}

// Main execution
async function main() {
  console.log('🚀 Drizzle Migration Analysis Tool\n');
  
  await generateMigrationReport();
  await suggestMigrationOrder();
  
  console.log('\n✨ Next steps:');
  console.log('1. Review MIGRATION_REPORT.md');
  console.log('2. Start with high-priority files');
  console.log('3. Test each migration thoroughly');
  console.log('4. Update imports and dependencies');
  console.log('5. Remove unused Knex code');
}

if (import.meta.url === `file://${process.argv[1]}`) {
  main().catch(console.error);
}

export { findKnexUsage, generateMigrationReport };