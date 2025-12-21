/**
 * Game Configuration Index
 * 
 * This file exports all game data from JSON configuration files.
 * These configs are designed to be easily modifiable by external contributors
 * via Pull Requests without touching application code.
 */

import professionsData from './professions.json';
import archetypesData from './archetypes.json';
import racesData from './races.json';
import itemRaritiesData from './itemRarities.json';
import supplyChainData from './supplyChain.json';

// Re-export with proper typing
export const professionsConfig = professionsData;
export const archetypesConfig = archetypesData;
export const racesConfig = racesData;
export const itemRaritiesConfig = itemRaritiesData;
export const supplyChainConfig = supplyChainData;

// Type definitions derived from config
export type ProfessionId = 
  | typeof professionsData.gathering[number]['id']
  | typeof professionsData.processing[number]['id']
  | typeof professionsData.crafting[number]['id'];

export type ArchetypeId = typeof archetypesData.list[number]['id'];
export type RaceId = typeof racesData.list[number]['id'];
export type RarityId = typeof itemRaritiesData.list[number]['id'];

// Helper functions
export function getProfessionById(id: string) {
  const allProfessions = [
    ...professionsData.gathering,
    ...professionsData.processing,
    ...professionsData.crafting,
  ];
  return allProfessions.find(p => p.id === id);
}

export function getArchetypeById(id: string) {
  return archetypesData.list.find(a => a.id === id);
}

export function getRaceById(id: string) {
  return racesData.list.find(r => r.id === id);
}

export function getClassName(primary: string, secondary: string): string | undefined {
  const classes = archetypesData.classes as Record<string, Record<string, string>>;
  return classes[primary]?.[secondary];
}

export function getSupplyChainForProfession(professionId: string) {
  return supplyChainData.chains.filter(chain => 
    chain.flow.includes(professionId)
  );
}
