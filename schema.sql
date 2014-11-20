SET foreign_key_checks = 0;
CREATE TABLE IF NOT EXISTS dnd_characterclass (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `prestige` tinyint(1) NOT NULL DEFAULT '0',
  `short_description` LONGTEXT NOT NULL,
  `short_description_html` LONGTEXT NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_characterclassvariant (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_class_id` int(11) NOT NULL,
  `rulebook_id` int(11) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `advancement` LONGTEXT NOT NULL,
  `advancement_html` LONGTEXT NOT NULL,
  `class_features` LONGTEXT NOT NULL,
  `skill_points` smallint(5)  DEFAULT NULL,
  `hit_die` smallint(5)  DEFAULT NULL,
  `alignment` varchar(256) NOT NULL,
  `class_features_html` LONGTEXT NOT NULL,
  `requirements` LONGTEXT NOT NULL,
  `requirements_html` LONGTEXT NOT NULL,
  `required_bab` smallint(5)  DEFAULT NULL,
  `starting_gold` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (character_class_id) REFERENCES dnd_characterclass(id) ON DELETE CASCADE,
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id)
);
CREATE TABLE IF NOT EXISTS dnd_characterclassvariant_class_skills (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterclassvariant_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (characterclassvariant_id) REFERENCES dnd_characterclassvariant(id) 
    ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES dnd_skill(id) 
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_characterclassvariantrequiresfeat (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_class_variant_id` int(11) NOT NULL,
  `feat_id` int(11) NOT NULL,
  `extra` varchar(32) NOT NULL,
  `text_before` varchar(64) NOT NULL,
  `text_after` varchar(64) NOT NULL,
  `remove_comma` tinyint(1) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (character_class_variant_id) REFERENCES dnd_characterclassvariant(id)
    ON DELETE CASCADE,
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_characterclassvariantrequiresrace (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_class_variant_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `extra` varchar(32) NOT NULL,
  `text_before` varchar(64) NOT NULL,
  `text_after` varchar(64) NOT NULL,
  `remove_comma` tinyint(1) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (character_class_variant_id) REFERENCES dnd_characterclassvariant(id)
    ON DELETE CASCADE,
  FOREIGN KEY (race_id) REFERENCES dnd_race(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_characterclassvariantrequiresskill (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_class_variant_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `ranks` smallint(5)  NOT NULL,
  `extra` varchar(32) NOT NULL,
  `text_before` varchar(64) NOT NULL,
  `text_after` varchar(64) NOT NULL,
  `remove_comma` tinyint(1) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (character_class_variant_id) REFERENCES dnd_characterclassvariant(id)
    ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES dnd_skill(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_deity (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  `alignment` varchar(2) NOT NULL,
  `favored_weapon_id` int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (favored_weapon_id) REFERENCES dnd_item(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS dnd_dndedition (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `system` varchar(16) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `core` tinyint(1) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_domain (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_domainvariant (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `rulebook_id` int(11) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `requirement` varchar(64) NOT NULL,
  `granted_power` LONGTEXT NOT NULL,
  `granted_power_html` LONGTEXT NOT NULL,
  `granted_power_type` varchar(8) NOT NULL,
  `deities_text` varchar(128) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (domain_id) REFERENCES dnd_domain(id) ON DELETE CASCADE,
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id)
);
CREATE TABLE IF NOT EXISTS dnd_domainvariant_deities (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domainvariant_id` int(11) NOT NULL,
  `deity_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (deity_id) REFERENCES dnd_deity(id)
    ON DELETE CASCADE,
  FOREIGN KEY (domainvariant_id) REFERENCES dnd_domainvariant(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_domainvariant_other_deities (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domainvariant_id` int(11) NOT NULL,
  `deity_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (deity_id) REFERENCES dnd_deity(id)
    ON DELETE CASCADE,
  FOREIGN KEY (domainvariant_id) REFERENCES dnd_domainvariant(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_feat (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rulebook_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `benefit` LONGTEXT NOT NULL,
  `special` LONGTEXT NOT NULL,
  `normal` LONGTEXT NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `slug` varchar(64) NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  `benefit_html` LONGTEXT NOT NULL,
  `special_html` LONGTEXT NOT NULL,
  `normal_html` LONGTEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id)
);
CREATE TABLE IF NOT EXISTS dnd_feat_feat_categories (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feat_id` int(11) NOT NULL,
  `featcategory_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (featcategory_id) REFERENCES dnd_featcategory(id)
    ON DELETE CASCADE,
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_featcategory (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_featrequiresfeat (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_feat_id` int(11) NOT NULL,
  `required_feat_id` int(11) NOT NULL,
  `additional_text` varchar(64) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (required_feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE,
  FOREIGN KEY (source_feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_featrequiresskill (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feat_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `min_rank` smallint(5)  NOT NULL,
  `extra` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES dnd_skill(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_featspecialfeatprerequisite (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feat_id` int(11) NOT NULL,
  `special_feat_prerequisite_id` int(11) NOT NULL,
  `value_1` varchar(256) NOT NULL,
  `value_2` varchar(256) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE,
  FOREIGN KEY (special_feat_prerequisite_id) REFERENCES dnd_specialfeatprerequisite(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_item (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `rulebook_id` int(11) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `price_gp` int(10)  DEFAULT NULL,
  `price_bonus` smallint(5)  DEFAULT NULL,
  `item_level` smallint(5)  DEFAULT NULL,
  `body_slot_id` int(11) DEFAULT NULL,
  `caster_level` smallint(5)  DEFAULT NULL,
  `aura_id` int(11) DEFAULT NULL,
  `aura_dc` varchar(16) NOT NULL,
  `activation_id` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `visual_description` LONGTEXT NOT NULL,
  `description` LONGTEXT NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  `type` varchar(3) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `cost_to_create` varchar(128) NOT NULL,
  `synergy_prerequisite_id` int(11) DEFAULT NULL,
  `required_extra` varchar(64) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (activation_id) REFERENCES dnd_itemactivationtype(id) ON DELETE SET NULL,
  FOREIGN KEY (aura_id) REFERENCES dnd_itemauratype(id) ON DELETE SET NULL,
  FOREIGN KEY (body_slot_id) REFERENCES dnd_itemslot(id) ON DELETE SET NULL,
  FOREIGN KEY (property_id) REFERENCES dnd_itemproperty(id) ON DELETE SET NULL,
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id),
  FOREIGN KEY (synergy_prerequisite_id) REFERENCES dnd_item(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS dnd_item_aura_schools (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `spellschool_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (item_id) REFERENCES dnd_item(id)
    ON DELETE CASCADE,
  FOREIGN KEY (spellschool_id) REFERENCES dnd_spellschool(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_item_required_feats (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `feat_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES dnd_item(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_item_required_spells (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `spell_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (item_id) REFERENCES dnd_item(id)
    ON DELETE CASCADE,
  FOREIGN KEY (spell_id) REFERENCES dnd_spell(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_itemactivationtype (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_itemauratype (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_itemproperty (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_itemslot (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_language (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_monster (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rulebook_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `size_id` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `hit_dice` varchar(32) NOT NULL,
  `initiative` smallint(6) NOT NULL,
  `armor_class` varchar(128) NOT NULL DEFAULT '32 (–1 size, +4 Dex, +19 natural)',
  `touch_armor_class` smallint(6) DEFAULT NULL,
  `flat_footed_armor_class` smallint(6) DEFAULT NULL,
  `base_attack` smallint(6) NOT NULL,
  `grapple` smallint(6) NOT NULL,
  `attack` varchar(128) NOT NULL DEFAULT '+3 greatsword +23 melee (3d6+13/19–20) or slam +20 melee (2d8+10)',
  `full_attack` varchar(128) NOT NULL DEFAULT '+3 greatsword +23/+18/+13 melee (3d6+13/19–20) or slam +20 melee (2d8+10)',
  `space` smallint(5)  NOT NULL,
  `reach` smallint(5)  NOT NULL,
  `special_attacks` varchar(256) NOT NULL,
  `special_qualities` varchar(512) NOT NULL,
  `fort_save` smallint(6) NOT NULL,
  `fort_save_extra` varchar(32) NOT NULL,
  `reflex_save` smallint(6) NOT NULL,
  `reflex_save_extra` varchar(32) NOT NULL,
  `will_save` smallint(6) NOT NULL,
  `will_save_extra` varchar(32) NOT NULL,
  `str` smallint(6) NOT NULL,
  `dex` smallint(6) NOT NULL,
  `con` smallint(6) DEFAULT NULL,
  `int` smallint(6) NOT NULL,
  `wis` smallint(6) NOT NULL,
  `cha` smallint(6) NOT NULL,
  `environment` varchar(128) NOT NULL,
  `organization` varchar(128) NOT NULL,
  `challenge_rating` smallint(5)  NOT NULL,
  `treasure` varchar(128) NOT NULL,
  `alignment` varchar(64) NOT NULL,
  `advancement` varchar(64) NOT NULL,
  `level_adjustment` smallint(6) DEFAULT NULL,
  `description` LONGTEXT NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  `combat` LONGTEXT NOT NULL,
  `combat_html` LONGTEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id),
  FOREIGN KEY (size_id) REFERENCES dnd_racesize(id),
  FOREIGN KEY (type_id) REFERENCES dnd_monstertype(id)
);
CREATE TABLE IF NOT EXISTS dnd_monster_subtypes (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monster_id` int(11) NOT NULL,
  `monstersubtype_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (monstersubtype_id) REFERENCES dnd_monstersubtype(id)
    ON DELETE CASCADE,
  FOREIGN KEY (monster_id) REFERENCES dnd_monster(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_monsterhasfeat (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monster_id` int(11) NOT NULL,
  `feat_id` int(11) NOT NULL,
  `extra` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE,
  FOREIGN KEY (monster_id) REFERENCES dnd_monster(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_monsterhasskill (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monster_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `ranks` smallint(5)  NOT NULL,
  `extra` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (monster_id) REFERENCES dnd_monster(id)
    ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES dnd_skill(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_monsterspeed (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `speed` smallint(5)  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (race_id) REFERENCES dnd_monster(id)
    ON DELETE CASCADE,
  FOREIGN KEY (type_id) REFERENCES dnd_speedtype(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_monstersubtype (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_monstertype (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_race (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rulebook_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `str` smallint(6) NOT NULL,
  `dex` smallint(6) NOT NULL,
  `con` smallint(6) DEFAULT NULL,
  `int` smallint(6) NOT NULL,
  `wis` smallint(6) NOT NULL,
  `cha` smallint(6) NOT NULL,
  `level_adjustment` smallint(6) NOT NULL DEFAULT '0',
  `size_id` int(11) NOT NULL DEFAULT '5',
  `space` smallint(5)  NOT NULL DEFAULT '5',
  `reach` smallint(5)  NOT NULL DEFAULT '5',
  `combat` LONGTEXT NOT NULL,
  `description` LONGTEXT NOT NULL,
  `racial_traits` LONGTEXT NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  `combat_html` LONGTEXT NOT NULL,
  `racial_traits_html` LONGTEXT NOT NULL,
  `natural_armor` smallint(6) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `race_type_id` int(11) DEFAULT NULL,
  `racial_hit_dice_count` smallint(5)  DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (race_type_id) REFERENCES dnd_racetype(id),
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id),
  FOREIGN KEY (size_id) REFERENCES dnd_racesize(id)
);
CREATE TABLE IF NOT EXISTS dnd_race_automatic_languages (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (language_id) REFERENCES dnd_language(id)
    ON DELETE CASCADE,
  FOREIGN KEY (race_id) REFERENCES dnd_race(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_race_bonus_languages (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (language_id) REFERENCES dnd_language(id)
    ON DELETE CASCADE,
  FOREIGN KEY (race_id) REFERENCES dnd_race(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_racefavoredcharacterclass (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_id` int(11) NOT NULL,
  `character_class_id` int(11) NOT NULL,
  `extra` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (character_class_id) REFERENCES dnd_characterclass(id)
    ON DELETE CASCADE,
  FOREIGN KEY (race_id) REFERENCES dnd_race(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_racesize (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `order` smallint(5)  NOT NULL,
  `description` LONGTEXT NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_racespeed (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `speed` smallint(5)  NOT NULL,
  `race_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (race_id) REFERENCES dnd_race(id)
    ON DELETE CASCADE,
  FOREIGN KEY (type_id) REFERENCES dnd_speedtype(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_speedtype (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `extra` varchar(32) DEFAULT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_racetype (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `hit_die_size` smallint(5)  NOT NULL,
  `base_attack_type` varchar(3) NOT NULL,
  `base_fort_save_type` varchar(4) NOT NULL,
  `base_reflex_save_type` varchar(4) NOT NULL,
  `base_will_save_type` varchar(4) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_rule (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `body` LONGTEXT NOT NULL,
  `body_html` LONGTEXT NOT NULL,
  `rulebook_id` int(11) NOT NULL,
  `page_from` smallint(5)  DEFAULT NULL,
  `page_to` smallint(5)  DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id)
);
CREATE TABLE IF NOT EXISTS dnd_rulebook (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dnd_edition_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `abbr` varchar(7) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `year` varchar(4) DEFAULT NULL,
  `official_url` varchar(255) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `published` date DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (dnd_edition_id) REFERENCES dnd_dndedition(id)
);
CREATE TABLE IF NOT EXISTS dnd_skill (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `base_skill` varchar(4) NOT NULL,
  `trained_only` tinyint(1) NOT NULL DEFAULT '0',
  `armor_check_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_skillvariant (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skill_id` int(11) NOT NULL,
  `rulebook_id` int(11) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `description` LONGTEXT NOT NULL,
  `check` LONGTEXT NOT NULL,
  `action` LONGTEXT NOT NULL,
  `try_again` LONGTEXT NOT NULL,
  `special` LONGTEXT NOT NULL,
  `synergy` LONGTEXT NOT NULL,
  `untrained` LONGTEXT NOT NULL,
  `description_html` LONGTEXT NOT NULL,
  `check_html` LONGTEXT NOT NULL,
  `action_html` LONGTEXT NOT NULL,
  `try_again_html` LONGTEXT NOT NULL,
  `special_html` LONGTEXT NOT NULL,
  `synergy_html` LONGTEXT NOT NULL,
  `untrained_html` LONGTEXT NOT NULL,
  `restriction` LONGTEXT NOT NULL,
  `restriction_html` LONGTEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id),
  FOREIGN KEY (skill_id) REFERENCES dnd_skill(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_specialfeatprerequisite (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `print_format` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_spell (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `added` datetime NOT NULL,
  `rulebook_id` int(11) NOT NULL,
  `page` smallint(5)  DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `school_id` int(11) NOT NULL,
  `sub_school_id` int(11) DEFAULT NULL,
  `verbal_component` tinyint(1) NOT NULL DEFAULT '0',
  `somatic_component` tinyint(1) NOT NULL DEFAULT '0',
  `material_component` tinyint(1) NOT NULL DEFAULT '0',
  `arcane_focus_component` tinyint(1) NOT NULL DEFAULT '0',
  `divine_focus_component` tinyint(1) NOT NULL DEFAULT '0',
  `xp_component` tinyint(1) NOT NULL DEFAULT '0',
  `casting_time` varchar(256) DEFAULT NULL,
  `range` varchar(256) DEFAULT NULL,
  `target` varchar(256) DEFAULT NULL,
  `effect` varchar(256) DEFAULT NULL,
  `area` varchar(256) DEFAULT NULL,
  `duration` varchar(256) DEFAULT NULL,
  `saving_throw` varchar(128) DEFAULT NULL,
  `spell_resistance` varchar(64) DEFAULT NULL,
  `description` LONGTEXT NOT NULL,
  `slug` varchar(64) NOT NULL,
  `meta_breath_component` tinyint(1) NOT NULL,
  `true_name_component` tinyint(1) NOT NULL,
  `extra_components` varchar(256) DEFAULT NULL,
  `description_html` LONGTEXT NOT NULL,
  `corrupt_component` tinyint(1) NOT NULL,
  `corrupt_level` smallint(5)  DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `verified_author_id` int(11) DEFAULT NULL,
  `verified_time` datetime DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rulebook_id) REFERENCES dnd_rulebook(id),
  FOREIGN KEY (school_id) REFERENCES dnd_spellschool(id),
  FOREIGN KEY (sub_school_id) REFERENCES dnd_spellsubschool(id)
);
CREATE TABLE IF NOT EXISTS dnd_spell_descriptors (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spell_id` int(11) NOT NULL,
  `spelldescriptor_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (spelldescriptor_id) REFERENCES dnd_spelldescriptor(id),
  FOREIGN KEY (spell_id) REFERENCES dnd_spell(id)
);
CREATE TABLE IF NOT EXISTS dnd_spellclasslevel (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_class_id` int(11) NOT NULL,
  `spell_id` int(11) NOT NULL,
  `level` smallint(5)  NOT NULL,
  `extra` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (character_class_id) REFERENCES dnd_characterclass(id)
    ON DELETE CASCADE,
  FOREIGN KEY (spell_id) REFERENCES dnd_spell(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_spelldescriptor (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_spelldomainlevel (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `spell_id` int(11) NOT NULL,
  `level` smallint(5)  NOT NULL,
  `extra` varchar(32) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (domain_id) REFERENCES dnd_domain(id)
    ON DELETE CASCADE,
  FOREIGN KEY (spell_id) REFERENCES dnd_spell(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_spellschool (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_spellsubschool (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `slug` varchar(32) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_staticpage (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `body` LONGTEXT NOT NULL,
  `body_html` LONGTEXT NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS dnd_textfeatprerequisite (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(256) NOT NULL,
  `feat_id` int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (feat_id) REFERENCES dnd_feat(id)
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS dnd_rules_conditions (
  `id` int(11) NOT NULL AUTO_INCREMENT, 
  `name` varchar(32) NOT NULL,
  `description` LONGTEXT NOT NULL,
  PRIMARY KEY (id)
);
SET foreign_key_checks = 1;