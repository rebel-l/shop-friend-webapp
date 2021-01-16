'use strict';

import {SHOP_LIST_ITEM_REMOVE} from "../../../types/shop/list/item";
import {SHOP_EDITOR_ITEM_ADD, SHOP_EDITOR_ITEM_UPDATE} from '../../../types/shop/editor';

const initialState = [];

/**
 * takes care about the actions regarding the items in shopping list.
 *
 * @param state
 * @param action
 * @returns {[]|(*)[]|*[]}
 */
export default function (state = initialState, action) {
    switch (action.type) {
        case SHOP_EDITOR_ITEM_ADD:
            return [...state, ...action.payload];
        case SHOP_EDITOR_ITEM_UPDATE:
            return state.map(item => {
                if (item.id === action.payload.id) {
                    return action.payload;
                }

                return item;
            });
        case SHOP_LIST_ITEM_REMOVE:
            return state.filter((item) => item.id !== action.payload);
        default:
            return state;
    }
}