% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Nhậm Lời Và Xót Thương" }
  composer = "Tv. 29"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8 e |
  d d b'16 (c) b8 |
  a4. g8 |
  c8. b16 a8 a |
  d2 ~ |
  d4 d8 bf |
  bf4. c8 |
  c a4 bf8 |
  g4 d8 bf' |
  a8. g16 d'8 d ~ |
  d e c d |
  b4 r8 b |
  b4 c8 a |
  b g a16 (g) e8 |
  e4. e8 |
  d d fs g |
  a4. g8 |
  c4 a8 d |
  g,2 \bar "||"
  
  g8 g g16 (a) g8 |
  e4. c8 |
  c8. g'16 g8 e |
  d2 ~ |
  d8 g fs16 (g) fs8 |
  e8. c'16 c8 b |
  a2 |
  fs8. a16 g8 e |
  d4 r8 g |
  a8. g16 a8 g |
  fs2 ~ |
  fs8 e e e16 (g) |
  a8. c16 b8 a |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 e |
  d d g16 (a) g8 |
  fs4. f!8 |
  e8. g16 g8 g |
  fs2 ~ |
  fs4 fs8 g |
  g4. g8 |
  ef d4 c8 |
  bf4 bf8 g' |
  d8. d16 b'!?8 b ~ |
  b c a g |
  g4 r8 g |
  g4 a8 fs |
  g e d [d] |
  c4. c8 |
  b b d e |
  fs4. e8 |
  a (g) fs fs |
  g2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin nhậm lời và xót thương con,
  lạy Chúa, xin Ngài trợ giúp.
  Khúc ai ca Chúa biến thành vũ điệu,
  Cởi áo xô, mặc cho con lễ phục huy hoàng,
  Nên con sẽ không ngớt lời ca tụng Ngài,
  muôn đời hằng tạ ơn mãi,
  lạy Chúa con kính thờ.
  <<
    {
      \set stanza = "1."
      Con xin tán ương Ngài,
      vì Ngài cất nhắc con lên,
      không để quân thù đắc chí trên con.
      Lạy Chúa con tôn thờ,
      con đã kêu cứu lên Ngài
      và ngài dủ thương chưa con an lành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ca khen thánh danh Ngài,
	    nào mọi tín hữu nơi nơi,
	    cơn giận của Ngài phút chốc phôi pha
	    mà mến thương muôn đời,
	    ban tối cho có rơi lệ,
	    vầng hồng vừa lên sướng vui reo hò.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Khi con sống yên hàn nhủ lòng mãi mãi không nao,
	    thanh thản luôn vì Chúa mến thương con
	    đặt giữa nơi an toàn,
	    nhưng mới khi Chúa ẩn mặt
	    là lòng dạ con xốn xang rợn rùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Bao nhiêu nắm tro tàn
	    nào còn hát kính Tôn Danh,
	    Khi đẩy con vào cõi chết thẳm sâu
	    thì Chúa đâu lợi gì?
	    Xin đoái nghe tiếng con cầu,
	    một niềm cậy trông Đấng con tôn thờ.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.4
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
