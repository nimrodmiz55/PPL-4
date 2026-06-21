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
% Example:
% ?- sub_list(X, [1, 2, 3]).
% X = [1, 2, 3] ; X = [1, 2] ; X = [1, 3] ; X = [2, 3] ;
% X = [1] ; X = [2] ; X = [3] ; X = [] ; false.

sub_list([], _).
sub_list([H|SubTail], [H|ListTail]) :- sub_list(SubTail, ListTail).
sub_list([SubHead|SubTail], [_|ListTail]) :- sub_list([SubHead|SubTail], ListTail).



% Signature: swap_list(+List, ?InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is
%          recursively replaced with the item at the mirrored position. Nested lists are also reversed.
% Example:
% ?- swap_list([a,b,c,d,e], T).  =>  T = [e,d,c,b,a]
% ?- swap_list([[a,b],[c,d],e], T).  =>  T = [e,[d,c],[b,a]]

swap_list(List, InversedList) :- swap_list_acc(List, [], InversedList).

swap_list_acc([], Acc, Acc).
swap_list_acc([H|T], Acc, Res) :-
    swap_item(H, SwappedH),
    swap_list_acc(T, [SwappedH|Acc], Res).

swap_item([], []) :- !.
swap_item([H|T], Swapped) :- !, swap_list_acc([H|T], [], Swapped).
swap_item(X, X).






% Signature: sub_tree(?Subtree, +Tree)/2
% Purpose: Tree contains Subtree.
% Example:
% ?- sub_tree(X, tree(a, tree(b,void,void), tree(c,void,void))).
% X = tree(b,void,void) ; X = tree(c,void,void) ;
% X = tree(a,tree(b,void,void),tree(c,void,void)) ; false.

sub_tree(Sub, tree(_, Left, _))  :- sub_tree(Sub, Left).
sub_tree(Sub, tree(_, _, Right)) :- sub_tree(Sub, Right).
sub_tree(Tree, Tree).



% Signature: swap_tree(+Tree, ?InversedTree)/2
% Purpose: InversedTree is the 'mirror' representation of Tree.
% Example:
% ?- swap_tree(tree(4,tree(2,tree(1,void,void),tree(3,void,void)),tree(5,void,void)),T).
% T = tree(4,tree(5,void,void),tree(2,tree(3,void,void),tree(1,void,void))) ; false.

swap_tree(void, void).
swap_tree(tree(V, L, R), tree(V, InvR, InvL)) :-
    swap_tree(L, InvL),
    swap_tree(R, InvR).
