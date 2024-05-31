# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_menu, mutation: Mutations::MenuMutations::CreateMenu
    field :update_menu, mutation: Mutations::MenuMutations::UpdateMenu
    field :delete_menu, mutation: Mutations::MenuMutations::DeleteMenu

    field :create_section, mutation: Mutations::SectionMutations::CreateSection
    field :update_section, mutation: Mutations::SectionMutations::UpdateSection
    field :delete_section, mutation: Mutations::SectionMutations::DeleteSection

    field :create_item, mutation: Mutations::ItemMutations::CreateItem
    field :update_item, mutation: Mutations::ItemMutations::UpdateItem
    field :delete_item, mutation: Mutations::ItemMutations::DeleteItem

    field :create_modifier_group, mutation: Mutations::ModifierGroupMutations::CreateModifierGroup
    field :update_modifier_group, mutation: Mutations::ModifierGroupMutations::UpdateModifierGroup
    field :delete_modifier_group, mutation: Mutations::ModifierGroupMutations::DeleteModifierGroup

    field :create_modifier, mutation: Mutations::ModifierMutations::CreateModifier
    field :update_modifier, mutation: Mutations::ModifierMutations::UpdateModifier
    field :delete_modifier, mutation: Mutations::ModifierMutations::DeleteModifier

    field :add_section_to_menu, mutation: Mutations::MenuSectionMutations::AddSectionToMenu
    field :remove_section_from_menu, mutation: Mutations::MenuSectionMutations::RemoveSectionFromMenu

    field :add_item_to_section, mutation: Mutations::SectionItemMutations::AddItemToSection
    field :remove_item_from_section, mutation: Mutations::SectionItemMutations::RemoveItemFromSection

    field :add_modifier_group_to_item, mutation: Mutations::ItemModifierGroupMutations::AddModifierGroupToItem
    field :remove_modifier_group_from_item, mutation: Mutations::ItemModifierGroupMutations::RemoveModifierGroupFromItem
    field :create_checkout_session, mutation: Mutations::CreateCheckoutSessionMutation
  end
end
