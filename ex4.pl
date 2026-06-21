/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).

sub_list([], _).
sub_list([H|SubTail], [H|ListTail]) :- sub_list(SubTail, ListTail).
sub_list([SubHead|SubTail], [_|ListTail]) :- sub_list([SubHead|SubTail], ListTail).



% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.

swap_list(List, InversedList) :- swap_list_acc(List, [], InversedList).

swap_list_acc([], Acc, Acc).
swap_list_acc([H|T], Acc, Res) :-
    swap_item(H, SwappedH),
    swap_list_acc(T, [SwappedH|Acc], Res).

swap_item([], []) :- !.
swap_item([H|T], Swapped) :- !, swap_list_acc([H|T], [], Swapped).
swap_item(X, X).






% Signature: sub_tree(Subtree, Tree)/2
% Purpose: Tree contains Subtree.

sub_tree(Sub, tree(_, Left, _))  :- sub_tree(Sub, Left).
sub_tree(Sub, tree(_, _, Right)) :- sub_tree(Sub, Right).
sub_tree(Tree, Tree).



% Signature: swap_tree(Tree, InversedTree)/2
% Purpose: InversedTree is the 'mirror' representation of Tree.

swap_tree(void, void).
swap_tree(tree(V, L, R), tree(V, InvR, InvL)) :-
    swap_tree(L, InvL),
    swap_tree(R, InvR).
