% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Đời Tựa Bóng Câu"
  composer = "Tv. 143"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 e8 c |
  f4. d16 g |
  g8 f f e |
  a4. g16 g |
  c8 c b c |
  d4. a16 a |
  b8 c a af |
  g2 ~ |
  g4 c,8 c |
  f4. d16
  <<
    { 
      \voiceOne
      d
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-2
      \tweak font-size #-2
      \parenthesize
      e
    }
  >>
  \oneVoice
  g8. f16 f8 e |
  a4. g16 g |
  c8 c b \slashedGrace { b16 ( } c8) |
  d4. a16 a |
  g8 e' d b |
  c2 ~ |
  c4 r8 \bar "||" \break
  
  g |
  e'4 d8 a ~ |
  a d b4 |
  c e,8 e ~ |
  e e a4 |
  a d,8 f ~ |
  f g c,4 |
  c c8 f ~ |
  f d g4 |
  g2 ~ |
  g8 [e'] d d |
  b c4 d8 |
  g,2 ~ |
  g8 g g af |
  g b4 d8 |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*15
  r4.
  g8 |
  c4 g8 f ~ |
  f fs g4 |
  e c8 c ~ |
  c c e4 |
  f b,8 d ~ |
  d b a4 |
  a a8 d ~ |
  d c c4 |
  b2 ~ |
  b8 c g' fs |
  g a4 f8 |
  e2 ~ |
  e8 e e f |
  e d4 f8 |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Ca mừng Chúa là núi đá cho tôi ẩn náu,
      Từng dạy tôi nên người thiện chiến,
      luyện thành tay võ nghệ cao cường,
      Là thành lũy, là đồn trú, khiên che, mộc đỡ.
      Nhờ Ngài nên tôi được giải thoát,
      Chư dân rầy đến quy phục tôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nghiêng trời xuống chạm tới núi cao cho tỏa khói,
	    Dùng loạt tên bay xẹt tia chớp,
	    diệt địch quân bấn loạn tan hàng,
	    Từ trời thẳm, nguyện Ngài hãy ra tay giải thoát,
	    Giựt mạng con lên khỏi vực thẳm
	    Xa tay quyền thế quân ngoại bang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ôi lạy Chúa nhận lấy khúc tân ca mừng Chúa,
	    Huyền cầm con vang họa dâng tiến,
	    vì Ngài thương cứu mạng trung thần.
	    Ngài giải cứu khỏi quyền thế tay quân ngoại quốc,
	    Miệng toàn buông bao lời xảo trá,
	    Giơ tay thề, nhưng luôn thề gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Mong được thấy, được thấy lũ con trai vừa lớn
	    Hùng mạnh như cây tràn nhựa sống,
	    đẹp tuối xuân thắm tươi muôn mầu,
	    Và được thấy bầy
	    \markup { \italic \underline "con" }
	    gái ta đầy khởi sắc,
	    Tuyệt vời như bao hình kiều nữ
	    In trên cột những cung điện kia.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hoa mầu tốt được chất chưa trong kho đầy ứ
	    Bầy cừu chiên tăng dần lên mãi,
	    tràn ngập trên khắp nẻo nương đồng,
	    Bò mập béo chẳng gục chết hay tan đàn nữa,
	    Và cầu mong trên mọi nẻo phố
	    Không vang tiếng ai sầu than.
    }
  >>
  \set stanza = "ĐK:"
  Lạy Chúa, con người có là chi mà Ngài cần biết đến,
  phàm nhân đáng là gì mà Chúa phải quan tâm?
  Khác chi hơi thở, ôi kiếp người,
  Vùn vụt tuổi đời tựa bóng câu.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
  bottom-margin = 15\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
