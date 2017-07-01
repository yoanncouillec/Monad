(* ------------------------------ NATURAL NUMBERS --------------------------- *)

Inductive mynat :=
| MyZero : mynat
| MySucc : mynat -> mynat.


(* --------------------------------- ADDITION ------------------------------- *)

Fixpoint add (a:mynat) (b:mynat) : mynat :=
  match a with
    | MyZero => b
    | MySucc x => MySucc (add x b)
  end.


Lemma add_zero_left: forall (a:mynat), add MyZero a = a.
Proof.
  simpl.
  reflexivity.
Qed.

Lemma add_zero_right: forall (a:mynat), add a MyZero = a.
Proof.
  induction a.
  simpl.
  reflexivity.
  simpl.  
  rewrite IHa.
  reflexivity.
Qed.

Lemma add_succ_left: forall (x y:mynat), add (MySucc x) y = MySucc (add x y).
Proof.
  intro x.
  intro y.
  induction x.
  simpl.
  reflexivity.
  simpl.
  reflexivity.
Qed.
  
Lemma add_succ_right: forall (a:mynat) (b:mynat), add a (MySucc b) = MySucc (add a b).
Proof.
  induction a.
  intro b.  
  simpl.  
  reflexivity.
  intro b.
  simpl.
  rewrite IHa.
  reflexivity.
Qed.
  
Lemma add_assoc: forall (a b c:mynat), add (add a b) c = add a (add b c).
Proof.
  intro a.
  intro b.
  induction c.
  rewrite add_zero_right.
  rewrite add_zero_right.
  reflexivity.
  rewrite add_succ_right.
  rewrite add_succ_right.
  rewrite add_succ_right.
  rewrite IHc.
  reflexivity.
Qed.

Lemma add_comm: forall (a:mynat) (b:mynat), add a b = add b a.
Proof.
  intro.
  intro.
  induction a.
  simpl.
  rewrite add_zero_right.
  reflexivity.
  simpl.
  rewrite IHa.
  rewrite add_succ_right.
  reflexivity.  
Qed.

(* ------------------------------ MULTIPLICATION ---------------------------- *)

Fixpoint mult (a:mynat) (b:mynat) : mynat :=
  match a with
    | MyZero => MyZero
    | MySucc x => add (mult x b) b
  end.

Eval simpl in (mult (MySucc (MySucc MyZero)) (MySucc (MySucc (MySucc MyZero)))).

Lemma mult_zero_left: forall (x:mynat), mult MyZero x = MyZero.
Proof.
  simpl.  
  reflexivity.
Qed.

Lemma mult_zero_right: forall (x:mynat), mult x MyZero = MyZero.
Proof.
  induction x.
  simpl.
  reflexivity.
  simpl.
  rewrite IHx.
  simpl.
  reflexivity.
Qed.

Lemma mult_one_distr_left: forall (x:mynat), mult (MySucc MyZero) (add (MySucc MyZero) x) =
                                   add (MySucc MyZero) (mult (MySucc MyZero) x).
Proof.
  induction x.
  simpl.  
  reflexivity.
  simpl.
  reflexivity.
Qed.
  
Lemma mult_one_left: forall (x:mynat), mult (MySucc MyZero) x = x.
Proof.
  induction x.
  rewrite mult_zero_right.
  reflexivity.
  rewrite mult_one_distr_left.
  simpl.
  reflexivity.
Qed.

Lemma mult_one_right: forall (x:mynat), mult x (MySucc MyZero) = x.
Proof.
  induction x.
  rewrite mult_zero_left.
  reflexivity.
  simpl.
  rewrite IHx.
  rewrite add_succ_right.
  rewrite add_zero_right.
  reflexivity.
Qed.

Lemma mult_succ_right: forall (x y:mynat), mult x (MySucc y) = add (mult x y) x.
Proof.
  intro x.
  intro y.
  induction x.  
  simpl.
  reflexivity.
  simpl.
  rewrite IHx.
  rewrite add_succ_right.
  rewrite add_succ_right.
  rewrite add_assoc.
  rewrite (add_comm x y).
  Check (add_assoc (mult x y) y x).
  rewrite <- (add_assoc (mult x y) y x).
  reflexivity.
Qed.

Lemma mult_succ_left: forall (x y:mynat), mult (MySucc x) y = add (mult x y) y.
Proof.
  intro x.
  intro y.
  induction x.
  simpl.
  reflexivity.
  simpl.
  reflexivity.  
Qed.

Lemma mult_distr_left: forall (k x y:mynat), mult k (add x y) =
                                             add (mult k x) (mult k y).
Proof.
  intro k.
  intro x.
  intro y.
  induction x.
  rewrite add_zero_left.
  rewrite mult_zero_right.
  rewrite add_zero_left.
  reflexivity.
  rewrite add_succ_left.
  rewrite mult_succ_right.  
  rewrite mult_succ_right.  
  rewrite IHx.
  rewrite add_assoc.
  Check (add_comm (mult k y) k).
  rewrite (add_comm (mult k y) k).
  rewrite add_assoc.
  reflexivity.
Qed.  

Lemma mult_distr_right: forall (k x y:mynat), mult (add x y) k =
                                             add (mult k x) (mult k y).
Proof.
  intro k.
  intro x.
  intro y.
  induction k.
  rewrite mult_zero_left.
  rewrite mult_zero_left.
  rewrite mult_zero_right.
  rewrite add_zero_left.
  reflexivity.
  rewrite mult_succ_right.
  rewrite mult_succ_left.
  rewrite mult_succ_left.  
  rewrite IHk.
  rewrite (add_assoc (mult k x) x (add (mult k y) y)).
  rewrite <- (add_assoc x (mult k y) y).
  rewrite (add_comm x (mult k y)).
  rewrite (add_assoc (mult k y) x y).
  rewrite <- (add_assoc (mult k x) (mult k y) (add x y)).
  reflexivity.
Qed.
  
Lemma mult_comm: forall (x y:mynat), mult x y = mult y x.
Proof.
  intro x.
  intro y.
  induction x.
  rewrite mult_zero_left.
  rewrite mult_zero_right.
  reflexivity.
  rewrite mult_succ_left.
  rewrite mult_succ_right.
  rewrite IHx.
  reflexivity.
Qed.

Fixpoint isLess (a b:mynat) :=
  match a, b with
    | MyZero, MyZero => false
    | MyZero, MySucc _ => true
    | MySucc _, MyZero => false
    | MySucc x, MySucc y => isLess x y
  end.

(* ----------------------------------- LIST --------------------------------- *)

Inductive mylist :=
| Empty
| Pair (hd:mynat) (tl:mylist).

Notation "hd :: tl" := (Pair hd tl).

Fixpoint insert (x:mynat) (l:mylist) :=
  match l with
    | Empty => Pair x Empty
    | Pair hd tl =>
      if (isLess x hd) then x::l else hd :: (insert x tl)
  end.

Fixpoint sort (l:mylist) :=
  match l with
    | Empty => Empty
    | Pair hd tl => insert hd (sort tl)
  end.
