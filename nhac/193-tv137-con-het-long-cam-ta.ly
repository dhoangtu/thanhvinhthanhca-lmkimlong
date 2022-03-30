% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Hết Lòng Cảm Tạ" }
  composer = "Tv. 137"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 c |
  f,4. g16 (f) |
  d4. c8 |
  a'8. bf16 a8 f |
  g g ~ g4 ~ |
  g c8 a |
  f4. g16 (f) |
  d4. c8 |
  f8. f16 e8 g |
  a8 a ~ a4 ~ |
  a a8. f16 |
  f8 bf4 bf8 ~ |
  bf g d' c |
  a2 ~ |
  a4 bf8. bf16 |
  a8 d,4 c8 ~ |
  c c g' e |
  f2 ~ |
  f4 \bar "||" \break
  
  f8. a16 |
  g8 f d4 ~ |
  d8 d f g |
  c,4. c8 |
  a'8. a16 f8 bf |
  a g ~ g4 |
  g8 bf c c |
  bf bf d (c16 bf) |
  g4 r8 e16 e |
  d8 g c, c |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 c |
  f,4. g16 (f) |
  d4. c8 |
  f8. g16 f8 d |
  e e ~ e4 ~ |
  e c'8 a |
  f4. g16 (f) |
  d4. c8 |
  a8. a16 c8 e |
  f f ~ f4 ~ |
  f f8. d16 |
  d8 g4 g8 ~ |
  g e bf' a |
  f2 ~ |
  f4 g8. g16 |
  c,8 bf4 a8 ~ |
  a a bf c |
  a2 ~ |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con hết lòng cảm tạ,
  vì Chúa đã nghe lời con xin,
  Trước chư vị thiên thần,
  này con xin đàn ca kính Chúa,
  Hướng về đền thánh con phục bái tôn thờ,
  Cảm mến danh Ngài,
  vì Ngài vẫn dủ thương.
  <<
    {
      \set stanza = "1."
      Mọi quốc vương trên trần đều xin cảm tạ
      vừa khi nghe lời Chúa tuyên ngôn.
      Họ đồng thanh ca ngợi đường lối Ngài,
      vinh quang Ngài vĩ đại dường bao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dù Chúa muôn cao trọng mà luôn dủ tình
	    nhìn xem ai hèn yếu cô thân.
	    Dù con đây khi gặp hồi hiểm nghèo
	    luôn luôn được Chúa bảo toàn cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Kìa ác nhân xông lại sục sôi oán hờn,
	    Ngài ra tay chặn đứng đi thôi,
	    Dùng bàn tay uy quyền để khuất phục,
	    xin thương mà tế độ hồn con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Việc Chúa thương đã làm rầy xin liễu thành,
	    vì Chúa vẫn trọn nghĩa yêu thương.
	    Mọi kỳ công tay Ngài từng khởi đầu
	    nay xin đừng lỡ bỏ dở dang.
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
}

TongNhip = {
  \key f \major \time 2/4
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
