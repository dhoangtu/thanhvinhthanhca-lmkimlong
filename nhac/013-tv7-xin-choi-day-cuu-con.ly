% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chỗi Dậy Cứu Con" }
  composer = "Tv. 7"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  c8. c16 d (c) e, (f) |
  g4. g8 |
  d8 f e (d) |
  c4 r8 e16 f |
  f8 d f a |
  g4. \slashedGrace { a16 ( } b) a |
  g8 b b d |
  c4 \bar "||"
  
  e,8 f |
  d8. g16 g8 a |
  e4 r8 e |
  c'4 b8 a |
  a8. d16 d8 e |
  b4 r8 b |
  c c r c |
  d d r e |
  a, b e, a |
  d, d g4 ~ |
  g g8 a |
  e4. e8 |
  c'4 b8 c |
  a4. f'8 |
  e4 r8 d |
  c d d8. e16 |
  c8 a4. ~ |
  a4 a8 b |
  g4. d'8 |
  c2 ~ |
  c4 r \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*7
  r4
  e,8 f |
  d8. g16 g8 a |
  e4 r8 e |
  a4 g8 a |
  f8. f16 fs8 fs |
  g4 r8 f |
  e e r g |
  f f r g |
  f e d d |
  c c b4 ~ |
  b g'8 a |
  e4. e8 |
  a4 g8 e |
  f4. a8 |
  g4 r8 b |
  a b b8. c16 |
  e,8 f4. ~ |
  f4 f8 d |
  e4. f8 |
  e2 ~ |
  e4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Ôi Thiên Chúa của con,
      con ẩn náu bên Ngài,
      xin cứu vớt và giải thoát con
      khỏi tay bọn đang truy nã con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Xin minh xét dùm con,
	    ôi thẩm phán công bình
	    luôn thấu suốt lòng dạ chúng sinh,
	    kẻ ngay lành hân hoan vững tâm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin Thiên Chúa trở nên khiên mộc chở che hoài.
	    Ai tín nghĩa, Ngài giải thoát cho.
	    Chúa cai trị công minh biết bao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Quân gian ác mài gươm trương nỏ lắp tên rồi,
	    mưu tính kế hoạch để sát nhân
	    với bao chuyện gian manh ác tâm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tôi lên tiếng ngợi ca bởi Ngài rất công bình,
	    xin tấu khúc nhạc lên hát ca
	    để ngợi khen Tôn Danh hiển vinh.
    }
  >>
  \set stanza = "ĐK:"
  Xin chỗi dậy tron cơn nghĩa nộ,
  Lạy Chúa, xin chỗi dậy trong cơn nghĩa nộ mà vung tay,
  mà vung tay chống lại quân thù thét lửa hại con,
  Xin chỗi dậy, lạy Chúa xin chỗi dậy cứu con
  theo lời công minh Chúa ban truyền,
  Xin chỗi dậy cứu con.
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
  page-count = 1
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
