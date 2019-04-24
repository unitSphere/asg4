(* /*
 * CSCI3180 Principles of Programming Languages
 *
 * --- Declaration ---
 *
 * I declare that the assignment here submitted is original except for source
 * material explicitly acknowledged. I also acknowledge that I am aware of
 * University policy and regulations on honesty in academic work, and of the
 * disciplinary guidelines and procedures applicable to breaches of such policy
 * and regulations, as contained in the website
 * http://www.cuhk.edu.hk/policy/academichonesty/
 *
 * Assignment 4
 * Name : Rustami Ubaydullo
 * Student ID : 1155102622
 * Email Addr : 1155102622@link.cuhk.edu.hk
 */ *)

datatype suit = Clubs | Diamonds | Hearts | Spades;
datatype rank = Jack | Queen | King | Ace | Num of int;
type card = suit * rank;
datatype color = Red | Black;
datatype move = Discard of card | Draw;
fun abs x = if x >= 0 then x else ~x;

(* Credit: Huzeyfe Kiran *)
fun cardColor(x:suit,y:rank):color = if x=Spades orelse x=Clubs then Black else Red;
fun cardValue(_,Jack) = 10
|   cardValue(_,Queen) = 10
|   cardValue(_,Ace) = 11
|   cardValue(_,King) = 10
|   cardValue(_,Num i) = i;

fun numOfCard(x:(suit*rank) list):int = length x;
fun removeCard(l:(suit*rank) list, s:suit, r:rank):(suit*rank) list =
        if (s,r) = hd(l) then tl(l)
        else [hd(l)]@removeCard(tl(l),s,r);

fun sumCards(l:(suit*rank) list, c:color):int =
        if null(l) then 0
        else if cardColor(hd(l)) = c then cardValue(hd(l)) + sumCards(tl(l),c)
        else sumCards(tl(l),c);

fun score(l:(suit*rank) list) = abs(sumCards(l,Red) - sumCards(l,Black)) + (6 - length(l));

fun runGame(deck,mvList) =
            let
                    fun runGameA([],Draw,mvList,hand) = score(hand)
                    |   runGameA(deck,Draw,mvList,hand) =
                                if length(hd(deck)::hand) > 5 orelse null(mvList) then score(hd(deck)::hand)
                                else runGameA(tl(deck),hd(mvList),tl(mvList),hd(deck)::hand)
                    |   runGameA(deck,Discard (x,y),mvList,hand) =
                                if null(mvList) then score(removeCard(hand,x,y))
                                else runGameA(deck,hd(mvList),tl(mvList),removeCard(hand,x,y))

            in
                    runGameA(deck,hd(mvList),tl(mvList),[])
            end;
